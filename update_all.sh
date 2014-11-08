#!/bin/sh
echo "Updating bundles in repo..."
cd .vim/bundle
for i in `ls`; do
	cd "$i"
		printf '[Bundle]:%s: ' $i
		git pull
	cd ..
done
echo "Copying bundles to ~/.vim..."
mv ~/.vim/bundle ~/.vim/bundle_backup
cp -r ../bundle ~/.vim/
rm -rf ~/.vim/bundle_backup
echo "Update finished."
