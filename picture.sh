#!/bin/bash
#TODO this doesn't work on 10.13 not sure how to fix it


# Script to set the profile picture for user X to picture Y
# via https://www.jamf.com/jamf-nation/discussions/4332/how-to-change-local-user-account-picture-through-command-terminal#responseChild162438

echo "0x0A 0x5C 0x3A 0x2C dsRecTypeStandard:Users 5 dsAttrTypeStandard:RecordName dsAttrTypeStandard:UniqueID dsAttrTypeStandard:PrimaryGroupID dsAttrTypeStandard:GeneratedUID externalbinary:dsAttrTypeStandard:JPEGPhoto" > /usr/local/share/import.txt
echo scott:501:$(id -g):$(dscl . -read /Users/$USER GeneratedUID | cut -d' ' -f2):"/Libary/User Pictures/meeseeks.jpg" >> /usr/local/share/import.txt
dscl . -delete /Users/$USER JPEGPhoto
dsimport /usr/local/share/import.txt /Local/Default M -u scott /usr/local/share/import.txt

exit 0
