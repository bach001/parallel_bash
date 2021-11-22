#!/bin/bash

# using python script from
# https://github.com/Spark-NF/twitter_media_downloader
# modified version

#<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

main () {

    split_cmd $users $sub_users

    #for ((i=1;i<=v;i++))
    for i in $parts_ ; do
        #echo $i
        # calling function without splitting the script?
        #do_sub_task $sub_users$i $task$i &
        sh rip_tw_sub_1.sh $sub_users$i $task$i > $i.out 2>&1 &
    done

    return $?
}

#<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

# can be anywhere in your PATH. If bash is in posix mode,
# it will not look in the current directory.
# This is all explained in the man page.
PATH=$PATH:$HOME/Public/script/bash

source rip_tw_pub.sh

cd $workdir && main && cd -

#<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
