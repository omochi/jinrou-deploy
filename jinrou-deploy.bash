#!/bin/bash
set -ue

copy_name_list=("config" "rss" "user_icon")
# grep pattern
ignore_pattern_list=("^\.git\$")
writable_list=("rss" "user_icon")

jinrou_path=""
deploy_path=""

# ref: copy_name_list
# $1: src-dir
# $2: dest-dir
copy_copy_targets(){
	for name in "${copy_name_list[@]}" ; do
		if [[ ! -e "$1/$name" ]] ; then
			echo "not exists: $1/$name"
			return 1
		fi
		if [[ ! -e "$2/$name" ]] ; then
			echo "copy $name"
			cp -R "$1/$name" "$2/$name"
		fi
	done
	return 0
}

# $1: path
get_abs_path(){
	local dir="$(cd "$(dirname "$1")" ; pwd)"
	echo "$dir/$(basename "$1")"
}

# ref: ignore_pattern_list
# $1: src-dir
# $2: dest-dir
link_all(){
	local IFS=$'\n'
	for name in $(ls -1A "$1") ; do
		local skip=0
		for pattern in "${ignore_pattern_list[@]}" ; do
			if [[ -n "$(echo "$name" | grep "$pattern")" ]] ; then
				skip=1
				break
			fi
		done
		if [[ "$skip" != 0 ]] ; then
			echo "ignored: $name"
			continue
		fi
		if [[ ! -e "$2/$name" ]] ; then
			local abs_path="$(get_abs_path "$1/$name")"
			echo "link: $name"
			ln -s "$abs_path" "$2/$name"
		fi
	done
	return 0
}

# $1: dir
remove_dead_links(){
	local IFS=$'\n'
	for name in $(ls -1A "$1") ; do
		if [[ -L "$1/$name" && ! -e "$1/$name" ]] ; then
			echo "remove dead link: $name"
			rm "$1/$name"
		fi
	done
	return 0
}

# ref: writable_list
# $1: dir
set_writable_perms(){
	for name in "${writable_list[@]}" ; do
		echo "set writable: $name"
		chmod a+w "$1/$name"
	done
	return 0
}

main(){
	if [[ $# -lt 2 ]] ; then
		echo "usage: $0 <jinrou_path> <deploy_path>"
		return 1
	fi
	jinrou_path="$1"
	deploy_path="$2"

	if [[ ! -e "$jinrou_path" ]] ; then
		echo "not exists: $jinrou_path"
		return 1
	fi
	if [[ ! -e "$deploy_path" ]] ; then
		echo "not exists: $deploy_path"
		return 1
	fi

	copy_copy_targets "$jinrou_path" "$deploy_path"
	link_all "$jinrou_path" "$deploy_path"
	remove_dead_links "$deploy_path"
	set_writable_perms "$deploy_path"

	return 0
}
main "$@"
exit $?

