#!/bin/sh
echo "Backing up orignal files..."
mv ~/.vimrc ~/.vimrc_backup
mv ~/.vim ~/.vim_backup
mv ~/.tmux.conf ~/.tmux.conf_backup

printf 'Installing files...\n'
cp -r .vimrc .vim .tmux.conf ~/

echo "Updating tmux theme..."
cd tmux-colors-solarized/
git pull

echo "Install tmux theme..."
cat tmuxcolors-light.conf >> ~/.tmux.conf

printf 'Updating bundles...\n'

cd ~/.vim/bundle
for i in `ls`; do
	cd "$i"
		printf '[Bundle]:%s: ' $i
		git pull
	cd ..
done



while true; do
    read -p "Do you wish to keep original config?[y/n]" yn
    case $yn in
        [Yy]* ) exit; break;;
        [Nn]* ) rm -rf ~/.vimrc_backup ~/.vim_backup ~/.tmux.conf_backup; break;;
        * ) echo "Please answer yes or no.";;
    esac
done

printf 'Installation finished.\n'
