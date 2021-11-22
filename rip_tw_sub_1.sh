#!/bin/bash

#<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

collect_urls () {
    # local variables
    local user=$1
    local task=$2
    local temp="$task.t"

    # call python script and generate a temporary
    # issue: python exception will cause process-exit
    python $pycmd -o $out_dir  -s large $user > $temp

    # filter out
    grep $url_mark $temp > $task

    rm $temp

    return $?
}

#<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

download () {
    # download each $1 = urls list
    local url_list=$1
    cat $url_list | while read url ; do
        local fname=$(expr $url : '.*/\([^?]*\)[:?].*')
        #echo $fname
        wget -nc $url -O $out_dir/$fname
    done

    return $?
}

#<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

do_sub_task () {
    # $1 users sublist $2 urls file
    local user_list=$1
    local task=$2
    # zero file
    [ -e "$task" ] && :> "$task"
    # fetch urls from each task
    echo "do_sub_task $user_list $task"
    for user in $(cat $user_list) ; do
        echo "@users: $user"
        collect_urls $user $task
    done

    local count=$(cat $task | wc -l | cut -d' ' -f1)

    [ "$count" -eq 0 ] && return $?

    #local load=$(ceiling $all $cores)
    # if there are too many urls
    echo "count $count $url_max"
    if [ "$count" -gt "$url_max" ] ; then
        # split the task
        local sub_task="sub_${task}_"
        split_cmd $task $sub_task
        for i in $parts_ ; do
            download ${sub_task}$i &
        done
    elif [ "$count" -le "$url_max" ]; then
        echo $task
        download $task &
    fi

    return $?
}

PATH=$PATH:$HOME/Public/script/bash

source rip_tw_pub.sh

do_sub_task $1 $2
