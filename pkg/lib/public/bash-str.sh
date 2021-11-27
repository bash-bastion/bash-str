# shellcheck shell=bash

# str.compare() {
# 	unset REPLY; REPLY=
# 	local str1="$1"
# 	local str2="$2"

# 	# TODO: set locale?
# 	# TODO: shopt -s nocaseglob, etc.
# 	if [[ $str1 > "$str2" ]]; then
# 		REPLY=1
# 	elif [[ $str2 < "$str1" ]]; then
# 		REPLY=-1
# 	else
# 		REPLY=0
# 	fi
# }

str.contains() {
	local str="$1"
	local substr="$2"

	if [[ $str == *"$substr"* ]]; then
		return 0
	else
		return 1
	fi
}

str.count() {
	unset REPLY; REPLY=
	local str="$1"
	local substr="$2"

	# local s="${str//"$substr"}"
	# REPLY="$(((${#str} - ${#s}) / ${#substr}))"

	local -i count=0
	local s="$str"
	until t=${s#*"$substr"}; [ "$t" = "$s" ]; do
		count=$((count + 1))
		s="$t"
	done
	REPLY=$count
}

str.fields() {
	unset REPLY; REPLY=
	local str="$1"

	# TODO: fix hack
	REPLY=($str)
}

str.has_prefix() {
	local str="$1"
	local prefix="$2"

	if [[ $str == "$prefix"* ]]; then
		return 0
	else
		return 1
	fi
}

str.has_suffix() {
	local str="$1"
	local prefix="$2"

	if [[ "$str" == *"$prefix" ]]; then
		return 0
	else
		return 1
	fi
}

str.index() {
	local str="$1"
	local substr="$2"

	local rest="${str#*$substr}"
	if ((${#rest} == ${#str})); then
		REPLY=-1
	else
		REPLY=$(( ${#str} - ${#rest} - ${#substr} ))
	fi
}

str.join() {
	unset REPLY; REPLY=
	local arr_name="$1"
	local sep="$2"

	local -n __arr="$arr_name"
	local i= item=
	for ((i=0; i<${#__arr[@]}-1; i++)); do
		item="${__arr[$i]}"
		REPLY+="${item}${sep}"
	done; unset i
	if ((${#__arr[@]} > 0)); then
		REPLY+="${__arr[-1]}"
	fi
}

str.last_index() {
	unset REPLY; REPLY=
	local str="$1"
	local substr="$2"

	local rest="${str##*$substr}"
	if ((${#rest} == ${#str})); then
		REPLY=-1
	else
		REPLY=$(( ${#str} - ${#rest} - ${#substr} ))
	fi
}
