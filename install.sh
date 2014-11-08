#!/bin/sh
echo "Backing up orignal files..."
mv ~/.vimrc ~/.vimrc_backup
mv ~/.vim ~/.vim_backup

printf 'Installing files...\n'
cp -r .vimrc .vim ~/

printf 'Updating bundles...\n'
cd ~/.vim/bundle
for i in `ls`; do
	cd "$i"
		printf '[Bundle]:%s: ' $i
		git pull
	cd ..
done

while true; do
    read -p "Do you wish to keep original config?" yn
    case $yn in
        [Yy]* ) exit; break;;
        [Nn]* ) rm -rf ~/.vimrc_backup ~/.vim_backup;;
        * ) echo "Please answer yes or no.";;
    esac
done

printf 'Installation finished.\n'
