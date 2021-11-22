

OIFS=$IFS

IFS=$(echo -en "\n\b")


for i in $(ls *)
do
    mv $i $i.m4a
done

#count=$1

#for i in $(ls *Course\ CD\ $2* | sort -k 12 -n)
#do
#trackno=$(echo ${i} | awk '{print $12}')

#echo $trackno
#echo "Michel Thomas - German Foundation (P$count. Foundation Course CD $2 Track $trackno.m4a"

#mv $i "Michel Thomas - German Foundation (P$count. Foundation Course CD $2 Track $trackno.m4a"

#echo "$count $trackno"
#mv $i "Michel Thomas - German Foundation (P$count. Foundation Course CD $2 Track $trackno)"
#let count=count+1
#done

IFS=$OIFS
