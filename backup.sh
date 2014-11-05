#!/bin/sh
cd ~/.vim/bundle
for i in `ls`; do
	cd "$i"
		printf '[Bundle]:%s: ' $i
		git pull
	cd ..
done
