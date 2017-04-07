#!/usr/bin/env bash

scriptPath=$(dirname $0)
source "$scriptPath/lib.sh"

SOURCES="sources"

execute() {
	local cd_info
	local exe_info
	local pwd_info

	if [[ -d $1 && $2 != "" ]]; then
		info "Executing ${2} for ${3} ..."
		pwd_info=$(pwd)
		cd $1
		exe_info=$(eval "${2}" 2>&1)
		if [[ $exe_info != "" ]]; then
			info "${3}: ${exe_info}"
		fi
		check_return "${exe_info}" q c
		cd $pwd_info
	fi
}


declare -A CONFIG
read_config() {
	CONFIG=(
		[remote]=""
		[prefix]=""
		[before]=""
		[finish]=""
	)
	while read line; do
		if [[ ${line} == *"="* ]]; then
			var=$(echo ${line} | cut -d '=' -f 1)
			CONFIG[${var}]=$(echo ${line} | cut -d '=' -f 2-)
		fi
	done < $1
}

git_clone_update() {
	local git_info
	local pwd_info

	info "Checking package ${3} ..."
	if [[ -d $2 && $(is_empty_folder $2) -eq 0 ]]; then
		info "Updating package ${3} ..."
		pwd_info=$(pwd)
		cd $2
		git_info="$(git pull 2>&1)"
		cd $pwd_info
		check_return "Update ${3} failed"
	else
		info "Installing package ${3} ..."
		git_info="$(git clone $1 $2 2>&1)"
		check_return "Installation ${3} failed"
	fi
	info "${git_info}"
}

main() {
	source_list="$(ls ${SOURCES})"
	check_return "No source folder found." q c
	for source in ${source_list}; do
		source_path="${SOURCES}/${source}"
		source_conf="${source}.conf"
		pkg_list=$(basename "$(ls ${source_path})")
		pkg_list=${pkg_list/${source_conf}/}
		read_config "${source_path}/${source_conf}"
		source_prefix=${CONFIG[prefix]}
		source_remote=${CONFIG[remote]}
		for pkg in ${pkg_list}; do
			pkg_path="${source_path}/${pkg}"
			read_config ${pkg_path}
			pkg_prefix="${source_prefix}${CONFIG[prefix]}"
			pkg_remote="${source_remote}${CONFIG[remote]}"
			pkg_before="${CONFIG[before]}"
			pkg_finish="${CONFIG[finish]}"
			if [[ ${pkg_prefix} == "~"* ]]; then
				pkg_prefix="${HOME}${pkg_prefix#'~'}"
			fi
			execute "${pkg_prefix}" "${pkg_before}" "${pkg}"
			git_clone_update $pkg_remote $pkg_prefix $pkg
			execute "${pkg_prefix}" "${pkg_finish}" "${pkg}"
		done
	done
}

main $@
