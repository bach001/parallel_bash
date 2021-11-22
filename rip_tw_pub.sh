#!/bin/bash

cores=$(grep -c "^processor" "/proc/cpuinfo")
workdir="$HOME/Video3/"
out_dir=$workdir/tw_download
pycmd="$HOME/Public/script/python/tw_dl/tw_dl.py"
url_max=20
url_mark="https://"

users="users.txt"
sub_users="users_"
task="task_"

# local suffix=$(printf "%02d" $i)
# brace expansion with variables not supported
# https://stackoverflow.com/
# questions/19432753/brace-expansion-with-variable
# using this for padding

sequence () {
    local start=$1
    local end=$2
    indices=$(eval echo "{$start..$end}")
    echo "$indices"
    return $?
}

parts_=$(sequence "00" "0$cores")

#echo "@cpu...$cores"
#split -n l/${cores} --numeric-suffixes $users $sub_users

split_cmd () {
    local input=$1
    local output=$2
    split -n l/${cores} --numeric-suffixes $input $output

    return $?
}

# load=$(((15+8-1)/8))
# all=$(wc -l $users)
# load=$(ceiling $all $cores)

ceiling () {
    local a=$1
    local b=$2
    echo $(($a+${b}-1/$b))
    return $?
}
