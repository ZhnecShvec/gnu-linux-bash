#!/bin/bash

dir=`dirname $0`
result_file="$dir/users_list.txt"

# settings:
count_users=10 # max users count

rm $result_file

for i in $(seq -w 1 $count_users); do

login="user$i"
password=$(pwgen -s 8 1)
line="$login,$password"
echo "$line" >> $result_file

#[ $i -eq 10 ] && exit 7 #FIXME: comment this line in production

done
