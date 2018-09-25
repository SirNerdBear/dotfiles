#!/usr/bin/env python
# -*- coding: utf-8 -*-

from __future__ import (unicode_literals, division, absolute_import, print_function)

import socket
import os
import errno
import sys
import fcntl
import atexit
import stat
import operator
import threading
import subprocess
import re
import time

from subprocess import Popen, PIPE 
from argparse import ArgumentParser
from select import select
from signal import signal, SIGTERM
from time import sleep
from functools import partial
from io import BytesIO
from threading import Event
from threading import Thread
from itertools import chain
from logging import StreamHandler
try:
	try:
		from time import clock_gettime

		# >={kernel}-sources-2.6.28
		from time import CLOCK_MONOTONIC_RAW as CLOCK_ID
	except ImportError:
		from time import CLOCK_MONOTONIC as CLOCK_ID

	monotonic = lambda: clock_gettime(CLOCK_ID)
except ImportError:
	import ctypes
	import sys

	try:
		if sys.platform == 'darwin':
			# Mac OS X
			from ctypes.util import find_library

			libc_name = find_library('c')
			if not libc_name:
				raise OSError

			libc = ctypes.CDLL(libc_name, use_errno=True)

			mach_absolute_time = libc.mach_absolute_time
			mach_absolute_time.argtypes = ()
			mach_absolute_time.restype = ctypes.c_uint64

			class mach_timebase_info_data_t(ctypes.Structure):
				_fields_ = (
					('numer', ctypes.c_uint32),
					('denom', ctypes.c_uint32),
				)
			mach_timebase_info_data_p = ctypes.POINTER(mach_timebase_info_data_t)

			_mach_timebase_info = libc.mach_timebase_info
			_mach_timebase_info.argtypes = (mach_timebase_info_data_p,)
			_mach_timebase_info.restype = ctypes.c_int

			def mach_timebase_info():
				timebase = mach_timebase_info_data_t()
				_mach_timebase_info(ctypes.byref(timebase))
				return (timebase.numer, timebase.denom)

			timebase = mach_timebase_info()
			factor = timebase[0] / timebase[1] * 1e-9

			def monotonic():
				return mach_absolute_time() * factor
		else:
			# linux only (no librt on OS X)
			import os

			# See <bits/time.h>
			CLOCK_MONOTONIC = 1
			CLOCK_MONOTONIC_RAW = 4

			class timespec(ctypes.Structure):
				_fields_ = (
					('tv_sec', ctypes.c_long),
					('tv_nsec', ctypes.c_long)
				)
			tspec = timespec()

			librt = ctypes.CDLL('librt.so.1', use_errno=True)
			clock_gettime = librt.clock_gettime
			clock_gettime.argtypes = [ctypes.c_int, ctypes.POINTER(timespec)]

			if clock_gettime(CLOCK_MONOTONIC_RAW, ctypes.pointer(tspec)) == 0:
				# >={kernel}-sources-2.6.28
				clock_id = CLOCK_MONOTONIC_RAW
			elif clock_gettime(CLOCK_MONOTONIC, ctypes.pointer(tspec)) == 0:
				clock_id = CLOCK_MONOTONIC
			else:
				raise OSError

			def monotonic():
				if clock_gettime(CLOCK_MONOTONIC, ctypes.pointer(tspec)) != 0:
					errno_ = ctypes.get_errno()
					raise OSError(errno_, os.strerror(errno_))
				return tspec.tv_sec + tspec.tv_nsec / 1e9

	except:
		from time import time as monotonic  # NOQA

def get_argparser():
	parser = ArgumentParser(description='Daemon that improves powerline performance.')
	parser.add_argument(
		'--quiet', '-q', action='store_true',
		help='Without other options: do not complain about already running '
			 'powerline-daemon instance. '
			 'Will still exit with 1. '
			 'With `--kill\' and `--replace\': do not show any messages. '
			 'With `--foreground\': ignored. '
			 'Does not silence exceptions in any case.'
	)
	parser.add_argument('--socket', '-s', help='Specify socket which will be used for connecting to daemon.')
	exclusive_group = parser.add_mutually_exclusive_group()
	exclusive_group.add_argument('--kill', '-k', action='store_true', help='Kill an already running instance.')
	replace_group = exclusive_group.add_argument_group()
	replace_group.add_argument('--foreground', '-f', action='store_true', help='Run in the foreground (don’t daemonize).')
	replace_group.add_argument('--replace', '-r', action='store_true', help='Replace an already running instance.')
	return parser

USE_FILESYSTEM = not sys.platform.lower().startswith('linux')

def run_cmd(cmd, stdin=None, strip=True):
	'''Run command and return its stdout, stripped
	If running command fails returns None and logs failure to ``pl`` argument.
	:param PowerlineLogger pl:
		Logger used to log failures.
	:param list cmd:
		Command which will be run.
	:param str stdin:
		String passed to command. May be None.
	:param bool strip:
		True if the result should be stripped.
	'''
	try:
		p = Popen(cmd, shell=False, stdout=PIPE, stdin=PIPE)
	except OSError as e:
		#pl.exception('Could not execute command ({0}): {1}', e, cmd)
		return None
	else:
		stdout, err = p.communicate(
			stdin if stdin is None else stdin.encode("utf-8"))
		stdout = stdout.decode("utf-8")
	return stdout.strip() if strip else stdout

def asrun(ascript):
	'''Run the given AppleScript and return the standard output and error.'''
	return run_cmd(['osascript', '-'], ascript)

class ThreadedSegment(Thread):
	daemon = True

	def __init__(self,thread_shutdown_event=None):
		super(ThreadedSegment, self).__init__()
		self.data=None
		self.thread_shutdown_event = thread_shutdown_event or Event()

	def __str__(self):
		return self.render()

	def do_work(self):
		pass #override

	def run(self,interval=1):
		while not self.thread_shutdown_event.is_set():
			start_time = monotonic()
			self.do_work()
			self.thread_shutdown_event.wait(max(interval - (monotonic() - start_time), 0.1))

class StaticSegment:
	__slots__ = ()

	def render(self,cols=75,tty=None):
		pass

	def __str__(self):
		return self.render()

def _convert_state(state):
	'''Guess player state'''
	state = state.lower()
	if 'play' in state:
		return 'play'
	if 'pause' in state:
		return 'pause'
	if 'stop' in state:
		return 'stop'
	return 'fallback'

def _convert_seconds(seconds):
	'''Convert seconds to minutes:seconds format'''
	return '{0:.0f}:{1:02.0f}'.format(*divmod(float(seconds), 60))

class ITunesPlayerSegment(ThreadedSegment):
	def get_player_status(self):
		status_delimiter = '-~`/='
		ascript = '''
			tell application "System Events"
				set process_list to (name of every process)
			end tell
			if process_list contains "iTunes" then
				tell application "iTunes"
					if player state is playing or player state is paused then
						set t_title to name of current track
						set t_artist to artist of current track
						set t_album to album of current track
						set t_duration to duration of current track
						set t_elapsed to player position
						set t_state to player state
						return t_title & "{0}" & t_artist & "{0}" & t_album & "{0}" & t_elapsed & "{0}" & t_duration & "{0}" & t_state
					end if
				end tell
			end if
		'''.format(status_delimiter)
		now_playing = asrun(ascript)
		if not now_playing:
			return
		now_playing = now_playing.split(status_delimiter)
		if len(now_playing) != 6:
			return
		title, artist, album = now_playing[0], now_playing[1], now_playing[2]
		state = _convert_state(now_playing[5])
		total = _convert_seconds(now_playing[4])
		elapsed = _convert_seconds(now_playing[3])
		return {
			'title': title,
			'artist': artist,
			'album': album,
			'total': total,
			'elapsed': elapsed,
			'state': state
		}

	def do_work(self):
		playerState = self.get_player_status()
		if playerState is None:
			self.data = None
			return
		icons = { u'play': 'ﱘ', u'pause': '' }
		playerState['icon'] = icons.get(playerState['state'],'')
		
		self.data = playerState#"%s %s - %s" % (playIcon, playerState['artist'], playerState['title'])

	def render(self,cols=75,tty=None):
		#need instead to shorten the song, etc.
		#if (self.data is not None and cols - len(self.data) <= 15): return None
		if self.data is not None:
			if cols <= 5: return self.data['icon']
			info = self.data['title']
			if (cols - len(info)) < 0:
				info = info[0:(cols)]
			if (len(self.data['artist']) + len(info) + 6) <= cols:
				info = self.data['artist'] + ' - ' + info
			return self.data['icon'] + ' ' + info


class VMachines(ThreadedSegment):
	def render(self,cols=75,tty=None):
		return self.data
	
	def do_work(self):
		raw = subprocess.check_output(['VBoxManage','list', 'runningvms']).decode('utf-8')
		vms = sum([1 for i in raw.split("\n") if i.strip()])
		self.data = "⧉ %d" % vms

class Dockers(ThreadedSegment):
	def render(self,cols=75,tty=None):
		return self.data

	def do_work(self):
		raw = subprocess.check_output(['docker','ps','-a','--format', '"{{.ID}}: {{.Status}}"']).decode('utf-8')
		match = re.findall(r'^"\w+:\s*(\w*?)\s',raw,re.MULTILINE)
		if match:
			downcase = operator.methodcaller('lower')
			docks = list(map(downcase,match))
			total = len(docks)
			up = [d for d in docks if d in ('up','running','restarting')]
			
			#  
			self.data = " %d#[nobold]/#[bold]%d" % ( len(up), total - len(up) )
		#created, restarting, running, removing, paused, exited, or dead
		# `docker ps -aq -f status=created -f status=paused -f status=exited -f status=dead | wc -l | bc`

#TODO get pane pid and lookup process to see if it's ssh, parsing options
class Host(StaticSegment):
	ssh_regex = re.compile(r'^\s*(\d+)\s((ssh|docker)\s.*?)$',re.MULTILINE)

	def render(self,cols=75,tty=None):
		if tty is not None:
			ps = subprocess.check_output(['ps', '-o', 'pid=,command=', '-t', tty]).decode("utf-8")
			#print(ps)
			


			m = Host.ssh_regex.search(ps)
			if m is not None:
				cmd = m.group(2).strip()
				#pid = m.group(1).strip()
				if cmd.startswith("ssh"):
					h = parse_ssh(cmd)
					host = h.get('host',None)
					if host is None: return None 
					if (h.get('port','22') != '22'):
						host += ":%s" % h['port']
					if ('user' in h and (cols - len(host)) >= 90):
						host = "%s@%s" % (h['user'],host)
					return "ssh://%s" % (host)
				elif cmd.startswith("docker"):
					m = re.search(r'exec -it\s(\w*?)\s\/bin\/bash\s*$',cmd)
					if m:
						ps = subprocess.check_output(["docker inspect --format '{{.Name}},{{.Config.Hostname}}' %s" % m.group(1)],shell=True).decode("utf-8")
						(name,container) = ps.strip().split(",",1)
						return " %s:%s" % (name,container)


		return " #h"

#should be a StaticSegment instead where it's always rendered in real-time
class Date(StaticSegment):
	def render(self,cols=75,tty=None):
		return " " + time.strftime('%x')

#TODO detect timezone as option and do UTC or local
class Time(StaticSegment):
	def render(self,cols=75,tty=None):
		return " " + time.strftime('%H:%M')

class TimeZone(StaticSegment):
	def render(self,cols=75,tty=None):
		return "PDT"

def start_segment_thread(seg, state):
	seg_name = seg.__name__
	if seg_name in state.started_segment_threads:
		return state.started_segment_threads[seg_name][0]
	thread_shutdown_event = Event()
	thread = seg(thread_shutdown_event)
	thread.start()
	state.started_segment_threads[seg_name] = (thread, thread_shutdown_event)
	return thread

class StatusLine():
	__segments__ = ( ITunesPlayerSegment, (VMachines,Dockers) , Host, (Date, Time, TimeZone) )
	__colors__ = (242,235,237,240)

	def _instantiate_segments(self,lst):
		out = []
		for item in lst:
			if isinstance(item, (list, tuple)):
				out.append(self._instantiate_segments(item))
			elif issubclass(item, ThreadedSegment):
				out.append( start_segment_thread(item,self.state) )
			elif issubclass(item, StaticSegment):
				out.append( item() )
		return out

	def __init__(self,state):
		self.state = state
		self.segments = self._instantiate_segments(StatusLine.__segments__)

	def true_length(self,str):
		"""Get length of segement by ignoring the #[stuff]"""
		return len(re.sub(r'#\[.*?\]','',str))

	def render(self,cols=75,tty=None):
		cols = min(cols-35,140) #140 is set as max status right size in tmux.conf
		color = 0
		out = []
		for seg in reversed(self.segments):

			if seg is None: continue
			rendered = []
			if isinstance(seg,(ThreadedSegment,StaticSegment)):
				s = seg.render(cols,tty)
				if s is None: continue
				cols -= self.true_length(s) + 3
				rendered.append(s)
			elif isinstance(seg, (list, tuple)):
				s = ' #[nobold]#[bold] '.join( filter(None,[s.render(cols,tty) for s in seg]) )
				if len(s) > 0:
					cols -= self.true_length(s) + 3
					rendered.append( s )
			if len(rendered) <= 0: continue
			colour = StatusLine.__colors__[color]
			rendered = ''.join(rendered)
			out.insert(0," #[fg=colour{colour}]#[fg=white,bold,bg=colour{colour}] {rendered}".format(**locals()) )
			color = (color + 1) % len(StatusLine.__colors__)
		return ''.join(out)


class NonInteractiveArgParser(ArgumentParser):
	def print_usage(self, file=None):
		raise Exception(self.format_usage())

	def print_help(self, file=None):
		raise Exception(self.format_help())

	def exit(self, status=0, message=None):
		pass

	def error(self, message):
		raise Exception(self.format_usage())


EOF = b'EOF\0\0'


class State(object):
	__slots__ = ('status_line', 'started_segment_threads', 'ts_shutdown_event')

	def __init__(self, **kwargs):
		self.started_segment_threads = {}
		self.status_line = StatusLine(self)
		self.ts_shutdown_event = Event()


HOME = os.path.expanduser('~')


# class NonDaemonShellPowerline(ShellPowerline):
# 	def get_log_handler(self):
# 		return StreamHandler()

def parse_ssh(cmd):
	#store for parsed values
	hash = {}

	#remove single character flags
	flags = '|'.join(list("46AaCfGgKkMNnqsTtVvXxYy"))
	cmd = re.sub(r"\s+-[%(flags)s]*[%(flags)s][%(flags)s]*" % locals(),'',cmd)
	
	#remove options
	opts = '|'.join(list("bBcDEeFIiJLlmOoQRSWw"))
	cmd = re.sub(r"\s+-[%s]\s+.*?(?=\s|$)" % opts,'',cmd)


	#extract port number if used
	def rep_port(m,hash=hash):
		hash['port'] = m.group(1)
		return ''
	cmd = re.sub(r"\s+-p\s+(.*?)(?=\s|$)", rep_port ,cmd)

	#drop ssh command
	cmd = re.sub(r'ssh\s+','',cmd)

	#take only host and username part not any command passed to ssh
	user = None
	host = cmd.split(' ',1)[0]
	if '@' in host:
		(user,host) = host.split('@',1)
	#should also look for the -l version of a passed username
	#would be cool to also look at .config

	hash['host'] = host
	hash['user'] = user

	return hash

def eintr_retry_call(func, *args, **kwargs):
	while True:
		try:
			return func(*args, **kwargs)
		except EnvironmentError as e:
			if getattr(e, 'errno', None) == errno.EINTR:
				continue
			raise


def do_read(conn, timeout=2.0):
	''' Read data from the client. If the client fails to send data within
	timeout seconds, abort. '''
	read = []
	end_time = monotonic() + timeout
	while not read or not read[-1].endswith(b'\0\0'):
		r, w, e = select((conn,), (), (conn,), timeout)
		if e:
			return
		if monotonic() > end_time:
			return
		if not r:
			continue
		x = eintr_retry_call(conn.recv, 4096)
		if x:
			read.append(x)
		else:
			break
	return b''.join(read)


def do_write(conn, result):
	try:
		eintr_retry_call(conn.sendall, result)
	except Exception:
		pass


def safe_bytes(o, encoding="utf-8"):
	'''Return bytes instance without ever throwing an exception.'''
	try:
		try:
			# We are assuming that o is a unicode object
			return o.encode(encoding, 'replace')
		except Exception:
			# Object may have defined __bytes__ (python 3) or __str__ method 
			# (python 2)
			# This also catches problem with non_ascii_bytes.encode('utf-8') 
			# that first tries to decode to UTF-8 using ascii codec (and fails 
			# in this case) and then encode to given encoding: errors= argument 
			# is not used in the first stage.
			return bytes(o)
	except Exception as e:
		return safe_bytes(str(e), encoding)

def get_answer(req, is_daemon, argparser, state):
	try:
		match = re.match(r'(\S+)-(\d+)',req)
		if match:
			return safe_bytes(state.status_line.render( int(match.group(2)), match.group(1) ))
		else:
			return safe_bytes('invalid args passed')
	except Exception as e:
		return safe_bytes(str(e))


def do_one(sock, read_sockets, write_sockets, result_map, is_daemon, argparser,
		   state):
	r, w, e = select(
		tuple(read_sockets) + (sock,),
		tuple(write_sockets),
		tuple(read_sockets) + tuple(write_sockets) + (sock,),
		60.0
	)

	if sock in e:
		# We cannot accept any more connections, so we exit
		raise SystemExit(1)

	for s in e:
		# Discard all broken connections to clients
		s.close()
		read_sockets.discard(s)
		write_sockets.discard(s)

	for s in r:
		if s == sock:
			# A client wants to connect
			conn, _ = eintr_retry_call(sock.accept)
			read_sockets.add(conn)
		else:
			# A client has sent some data
			read_sockets.discard(s)
			req = do_read(s)
			if req == EOF:
				raise SystemExit(0)
			elif req:
				ans = get_answer(req, is_daemon, argparser, state)
				result_map[s] = ans
				write_sockets.add(s)
			else:
				s.close()

	for s in w:
		# A client is ready to receive the result
		write_sockets.discard(s)
		result = result_map.pop(s)
		try:
			do_write(s, result)
		finally:
			s.close()


def shutdown(sock, read_sockets, write_sockets, state):
	'''Perform operations necessary for nicely shutting down daemon

	Specifically it

	#. Closes all sockets.
	#. Notifies segments based on 
	  :py:class:`powerline.lib.threaded.ThreadedSegment` and WM-specific 
	  threads that daemon is shutting down.
	#. Waits for threads to finish, but no more then 2 seconds total.
	#. Waits so that total execution time of this function is 2 seconds in order 
	   to allow ThreadedSegments to finish.
	'''
	total_wait_time = 2
	shutdown_start_time = monotonic()

	for s in chain((sock,), read_sockets, write_sockets):
		s.close()

	# Notify ThreadedSegments
	state.ts_shutdown_event.set()
	for thread, shutdown_event in state.started_segment_threads.values():
		shutdown_event.set()

	for thread, shutdown_event in state.started_segment_threads.values():
		wait_time = total_wait_time - (monotonic() - shutdown_start_time)
		if wait_time > 0:
			thread.join(wait_time)

	wait_time = total_wait_time - (monotonic() - shutdown_start_time)
	sleep(wait_time)


def main_loop(sock, is_daemon):
	sock.listen(128)
	sock.setblocking(0)

	read_sockets, write_sockets = set(), set()
	result_map = {}
	state = State()

	try:
		try:
			while True:
				do_one(
					sock, read_sockets, write_sockets, result_map,
					is_daemon=is_daemon,
					argparser=None,
					state=state,
				)
		except KeyboardInterrupt:
			raise SystemExit(0)
	except SystemExit as e:
		shutdown(sock, read_sockets, write_sockets, state)
		raise e
	return 0


def daemonize(stdin=os.devnull, stdout=os.devnull, stderr=os.devnull):
	try:
		pid = os.fork()
		if pid > 0:
			# exit first parent
			raise SystemExit(0)
	except OSError as e:
		sys.stderr.write("fork #1 failed: %d (%s)\n" % (e.errno, e.strerror))
		raise SystemExit(1)

	# decouple from parent environment
	os.chdir("/")
	os.setsid()
	os.umask(0)

	# do second fork
	try:
		pid = os.fork()
		if pid > 0:
			# exit from second parent
			raise SystemExit(0)
	except OSError as e:
		sys.stderr.write("fork #2 failed: %d (%s)\n" % (e.errno, e.strerror))
		raise SystemExit(1)

	# Redirect standard file descriptors.
	si = open(stdin, 'rb')
	so = open(stdout, 'a+b')
	se = open(stderr, 'a+b', 0)
	os.dup2(si.fileno(), sys.stdin.fileno())
	os.dup2(so.fileno(), sys.stdout.fileno())
	os.dup2(se.fileno(), sys.stderr.fileno())
	return True


def check_existing(address):
	if USE_FILESYSTEM:
		# We cannot bind if the socket file already exists so remove it, we
		# already have a lock on pidfile, so this should be safe.
		try:
			os.unlink(address)
		except EnvironmentError:
			pass

	sock = socket.socket(family=socket.AF_UNIX)
	try:
		sock.bind(address)
	except socket.error as e:
		if getattr(e, 'errno', None) == errno.EADDRINUSE:
			return None
		raise
	return sock


def kill_daemon(address):
	sock = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
	try:
		try:
			eintr_retry_call(sock.connect, address)
		except socket.error:
			return False
		else:
			eintr_retry_call(sock.sendall, EOF)
	finally:
		sock.close()
	return True


def cleanup_lockfile(pidfile, fd, *args):
	try:
		# Remove the directory entry for the lock file
		os.unlink(pidfile)
		# Close the file descriptor
		os.close(fd)
	except EnvironmentError:
		pass
	if args:
		# Called in signal handler
		raise SystemExit(1)


def lockpidfile(pidfile):
	fd = os.open(
		pidfile,
		os.O_WRONLY | os.O_CREAT,
		stat.S_IRUSR | stat.S_IWUSR | stat.S_IRGRP | stat.S_IROTH
	)
	try:
		fcntl.lockf(fd, fcntl.LOCK_EX | fcntl.LOCK_NB)
	except EnvironmentError:
		os.close(fd)
		return None
	os.lseek(fd, 0, os.SEEK_SET)
	os.ftruncate(fd, 0)
	os.write(fd, ('%d' % os.getpid()).encode('ascii'))
	os.fsync(fd)
	cleanup = partial(cleanup_lockfile, pidfile, fd)
	signal(SIGTERM, cleanup)
	atexit.register(cleanup)
	return fd


def main():
	parser = get_argparser()
	args = parser.parse_args()
	is_daemon = False
	address = None
	pidfile = None

	if args.socket:
		address = args.socket
		if not USE_FILESYSTEM:
			address = '\0' + address
	else:
		if USE_FILESYSTEM:
			address = '/tmp/powerline-ipc-%d'
		else:
			# Use the abstract namespace for sockets rather than the filesystem
			# (Available only in linux)
			address = '\0powerline-ipc-%d'

		address = address % os.getuid()

	if USE_FILESYSTEM:
		pidfile = address + '.pid'

	if args.kill:
		if args.foreground or args.replace:
			parser.error('--kill and --foreground/--replace cannot be used together')
		if kill_daemon(address):
			if not args.quiet:
				print ('Kill command sent to daemon, if it does not die in a couple of seconds use kill to kill it')
			raise SystemExit(0)
		else:
			if not args.quiet:
				print ('No running daemon found')
			raise SystemExit(1)

	if args.replace:
		while kill_daemon(address):
			if not args.quiet:
				print ('Kill command sent to daemon, waiting for daemon to exit, press Ctrl-C to terminate wait and exit')
			sleep(2)

	if USE_FILESYSTEM and not args.foreground:
		# We must daemonize before creating the locked pidfile, unfortunately,
		# this means further print statements are discarded
		is_daemon = daemonize()

	if USE_FILESYSTEM:
		# Create a locked pid file containing the daemon’s PID
		if lockpidfile(pidfile) is None:
			if not args.quiet:
				sys.stderr.write(
					'The daemon is already running. Use %s -k to kill it.\n' % (
						os.path.basename(sys.argv[0])))
			raise SystemExit(1)

	# Bind to address or bail if we cannot bind
	sock = check_existing(address)
	if sock is None:
		if not args.quiet:
			sys.stderr.write(
				'The daemon is already running. Use %s -k to kill it.\n' % (
					os.path.basename(sys.argv[0])))
		raise SystemExit(1)

	if not USE_FILESYSTEM and not args.foreground:
		# We daemonize on linux
		is_daemon = daemonize()

	return main_loop(sock, is_daemon)


if __name__ == '__main__':
	main()
