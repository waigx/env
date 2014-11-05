#!/bin/sh
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
printf 'Finished.\n'
