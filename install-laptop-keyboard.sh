#!/bin/bash

INSTALL_DIR=xmodmap-my-conf
DATE=$(date +%Y%m%d%H%M%S)
BACKUP_DIR="$INSTALL_DIR-backup-$DATE"


echo -n "Backing up previous xmodmap keycode and keysyms in ~/xmodmap-pke-original ... "
mkdir ~/$BACKUP_DIR
xmodmap -pke >  ~/$BACKUP_DIR/xmodmap-pke
echo "success"
echo "To restore backed up xmodmap keycode and keysyms run: xmodmap ~/xmodmap-pke-original"

echo "Checking for previous xmodmap configuration"
if [ -f ~/.xmodmaprc ] || [ -d ~/$INSTALL_DIR ]
then
	echo "You already have an existing xmodmap configuration"
	echo -n "Trying to back it up in ~/$BACKUP_DIR ... "
	mv ~/.xmodmaprc ~/$BACKUP_DIR
	mv ~/$INSTALL_DIR ~/$BACKUP_DIR
	echo "success"
fi


echo "Installing xmodmap configuration in ~/$INSTALL_DIR"

echo "Cloning my xmodmap laptop configuration from GitHub in ~/$INSTALL_DIR"
git clone https://github.com/taringamberini/my-xmodmap-configuration.git ~/$INSTALL_DIR

echo -n "Creating symlink ... "
ln -s ~/$INSTALL_DIR/xmodmaprc-laptop-keyboard ~/.xmodmaprc
echo "success"

echo "xmodmap laptop installation completed :-)"

