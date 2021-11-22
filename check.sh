#!/bin/bash

for i in task_?? ; do
    cat $i | while read url ; do
        fname=$(expr $url : '.*/\([^?]*\)[:?].*')
        fpath="./tw_download/$fname"
        if [ -e "$fpath" ] ; then
            size=$(stat -c "%s" -- "$fpath")
            if [ "$size" -le 0 ] ; then
                echo "$i exist size: $size"
                #wget $url -O $fpath &
            fi
        else
            echo "$i does not exist"
            #wget $url -O $fpath &
        fi
    done
done
