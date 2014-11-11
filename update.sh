#!/bin/sh
echo "Updating tmux theme"
cd tmux-colors-solarized/
git pull
echo "Updating bundles in repo..."
cd ../.vim/bundle
for i in `ls`; do
	cd "$i"
		printf '[Bundle]:%s: ' $i
		git pull
	cd ..
done
echo "Copying theme and bundles to ~/..."
mv ~/.vim/bundle ~/.vim/bundle_backup
mv ~/.tmux.conf ~/.tmux.conf_backup
cd ../..

cp .tmux.conf ~/
cat tmux-colors-solarized/tmuxcolors-light.conf >> ~/.tmux.conf

cp -r .vim/bundle ~/.vim/

rm -rf ~/.vim/bundle_backup ~/.tmux.conf_backup

echo "Update finished."
