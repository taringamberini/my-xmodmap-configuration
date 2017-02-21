#!/bin/bash

INSTALL_DIR=xmodmap-my-conf
DATE=$(date +%Y%m%d%H%M%S)
echo "Installing xmodmap configuration in ~/$INSTALL_DIR"

echo "Checking for previous xmodmap configuration"
if [ -f ~/.xmodmaprc ] || [ -d ~/$INSTALL_DIR ]
then
	echo "You already have an existing xmodmap configuration"
	BACKUP_DIR="xmodmap-configuration-backup-$DATE"
	echo -n "Trying to back it up in ~/$BACKUP_DIR ... "
	mkdir ~/$BACKUP_DIR
	mv ~/.xmodmaprc ~/$BACKUP_DIR
	mv ~/$INSTALL_DIR ~/$BACKUP_DIR
	echo "success"
fi

echo -n "Backing up previous xmodmap keycode and keysyms in ~/xmodmap-pke-original ... "
xmodmap -pke > ~/xmodmap-pke-original-$DATE
echo "success"
echo "To restore backed up xmodmap keycode and keysyms run: xmodmap ~/xmodmap-pke-original"

echo "Cloning my xmodmap configuration from GitHub in ~/$INSTALL_DIR"
git clone https://github.com/taringamberini/my-xmodmap-configuration.git ~/$INSTALL_DIR

echo -n "Creating symlink ... "
ln -s ~/$INSTALL_DIR/xmodmaprc-laptop-keyboard ~/.xmodmaprc
echo "success"

echo "xmodmap installation completed :-)"

