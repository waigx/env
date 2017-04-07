#!/usr/bin/env bash

ts() {
	echo $(date +'%m-%d %H:%M:%S')
}

err() {
	while read line; do
		echo "[$(ts)]: $line" >&2
	done <<< "${@}"
}

info() {
	while read line; do
		echo "[$(ts)]: $line" >&1
	done <<< "${@}"
}

ask() {
	local input

	read -p "[$(ts)]: $@" input >&1
	echo "${input}"
}

is_empty_folder() {
	if [[ "$(ls -A ${1} 2>&1)" ]]; then
		echo 0
	else
		echo 1
	fi
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

