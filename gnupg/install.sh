chmod 700 $XDG_DATA_HOME/gnupg/

#Restore keys (these were created by install script from lpass backup)
for f in ~/.ssh/*_ed25519; do gpg --import $f; done

#remove existing trustdb
#/Users/scott/.local/share/gnupg
DEF_DIR=~/.gnupg
rm "${GNUPGHOME:-$DEF_DIR}"/trustdb.gpg

#import from backup (put into init by install script from lpass backup)
gpg --import-ownertrust < $XDG_CONFIG_HOME/init/trustdb.txt


#If you didn’t back up your trust database,
#the restored GPG key(s) will have an “unknown” trust level.
#To set it to “ultimate” or another trust level, run the following command:

# $ gpg --edit-key name # Replace "name" with yours
# $ gpg> trust # Choose "ultimate" or other trust level
# $ gpg> save 

