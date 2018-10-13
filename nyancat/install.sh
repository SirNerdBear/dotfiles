#!/usr/bin/env bash
set -e
cd
git clone --depth=1 https://github.com/klange/nyancat.git
cd ~/nyancat && make && mv ~/nyancat/src/nyancat ~/.local/bin/
cd
rm -rf ~/nyancat
