#/bin/bash

outdir="dups"
mkdir $outdir >/dev/null 2>&1

check() {
    #  actually passing 3 arguments we need to prevent splitting
    [ -e "$*" ] && dup_size=$(IFS= && stat -c "%s" -- "$*") && {

        if [ "$size" -ge "$dup_size" ] ; then
            # move out the lesser one
            mv -v -- "$*" $outdir
        elif [ "$size" -lt "$dup_size" ] ; then
            mkdir 11 >/dev/null 2>&1
            # rename the bigger one
            mv -v -- "$i" 11
            mv -v -- "$*" $i
        fi
    }
    : '&&
       #echo "$1 $2 $3"
       [ "$size" -ne "$dup_size" ] &&
          echo "$i $size : $* $dup_size" ||
            mv -v -- "$*" $outdir'
}

check_dup () {
    # dups
    # out=$(some_command) && echo "$out" > outfile
    # echo "$out" > outfile will execute only when some_command succeeds.
    # Note: If the output of some_command is huge, you may want to
    # t=$(mktemp); some_command >$t && cat $t > outfile; rm -f $t
    #t=$(mktemp); ls -- "[*$1"
    # all this is not what i want
    ls -- [*$1 2>/dev/null | while read j; do
        #echo $j
        check "$j"
    done
}

regex='([^\.]*)\.([^\.]*)'
#for i in "$(ls -- [*)"; do
ls -- [^\[]*.* | while read i; do
    size=$(stat -c "%s" -- "$i")
    #dup=$(echo $i | cut -d' ' -f3)
    [[ $i =~ $regex ]] && {
        fname=${BASH_REMATCH[1]}
        ext=${BASH_REMATCH[2]}
    }
    #echo ${var1,,} ${var2,,} ${var1^^} ${var2^^}
    check_dup "${fname,,}.${ext}"
    check_dup "${fname^^}.${ext}"
done
