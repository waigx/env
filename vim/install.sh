#!/usr/bin/env bash

SOURCES="sources"


ts() {
	echo $(date +'%Y-%m-%dT%H:%M:%S%z')
}

err() {
	echo "[$(ts)]: $@" >&2
}

info() {
	echo "[$(ts)]: $@" >&1
}

ask() {
	local input

	read -p "[$(ts)]: $@" input >&1
	echo "${input}"
}

check_return() {
	if [[ "$?" -ne 0 ]]; then
		err $1
		local input

		if [[ $2 == "q" ]]; then
			if [[ $3 == "c" ]]; then
				while true; do
					input=$(ask "Do you wish to continue[y/n]: ")
					case ${input} in
						[Yy]* ) break ;;
						[Nn]* ) err "Exit due to $1"; exit 1 ;;
						* ) info "Please answer Yes[y] or No[n]" ;;
					esac
				done
			else
				err "Exit due to $1"
				exit 1
			fi
		fi
	fi
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
	check_return "No source folder found." q c
}

main() {
	source_list="$(ls ${SOURCES})"
	check_return "No source folder found." q c
	
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
			info $pkg_prefix
			info $pkg_remote
		done
	done
}

main $@
