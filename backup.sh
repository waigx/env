#!/bin/sh
echo "Backing up..."
mv .vimrc .vimrc_backup
mv .vim .vim_backup

echo "Copying current .vimrc file and .vim folder..."
cp -r ~/.vimrc ~/.vim ./

echo "Delecting backup files..."
rm .vimrc_backup
rm -rf .vim_backup

echo "VIM configuration backuped, please backup .tmux.conf manually"
