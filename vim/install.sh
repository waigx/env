#!/usr/bin/env bash

SOURCES="sources"

err() {
	echo "[$(date +'%Y-%m-%dT%H:%M:%S%z')]: $@" >&2
}

declare -A CONFIG
read_config() {
	CONFIG=(
		[remote]=""
		[prefix]=""
	)
	while read line; do
		if [[ ${line} == *"="* ]]; then
			var=$(echo ${line} | cut -d '=' -f 1)
			CONFIG[${var}]=$(echo ${line} | cut -d '=' -f 2)
		fi
	done < $1
}

git_clone_update() {
	git clone $1 $2
}


source_list="$(ls ${SOURCES})"

if [[ "$?" -ne 0 ]]; then
	err "No source folder found."
	exit 1
fi

for source in ${source_list}; do
	source_path="${SOURCES}/${source}"
	source_conf="${source}.conf"
	pkg_list=$(basename $(ls ${source_path}))
	pkg_list=${pkg_list/${source_conf}/}
	read_config "${source_path}/${source_conf}"
	source_prefix=${CONFIG[prefix]}
	source_remote=${CONFIG[remote]}
	for pkg in ${pkg_list}; do
		pkg_path="${source_path}/${pkg}"
		read_config ${pkg_path}
		pkg_prefix="${source_prefix}${CONFIG[prefix]}"
		pkg_remote="${source_remote}${CONFIG[remote]}"
		if [[ ${pkg_prefix} == "~"* ]]; then
			pkg_prefix="${HOME}${pkg_prefix#'~'}"
		fi
		git_clone_update ${pkg_remote} ${pkg_prefix}
	done
done

