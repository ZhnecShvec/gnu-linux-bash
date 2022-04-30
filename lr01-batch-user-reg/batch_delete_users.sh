#!/bin/bash

#[ "$1" == "with-backup" ] && echo "backup"
# exit 9

dir=`dirname $0`
source_file="$dir/users_list.txt"

iter_num=1
key_flag=0

if [ $# -ne 0 ];then
case "$1" in
-b) key_flag=1;;
*) echo "invalid key"
   exit 8;;
esac
fi

for user_data in $(cat "$source_file"); do

login=$(echo "$user_data" | awk -F ',' {'print $1'})

echo "Delete user with login: $login ..."

if [ $key_flag -eq 1 ];then
cd /home/
    if [ $iter_num -eq 1 ];then
    tar -cf /opt/backup.tar $login
    else
    tar -rf /opt/backup.tar $login
    fi
fi

deluser --remove-home "$login" &>>/dev/null

if [ $? -ne 0 ];then
echo "error: User does not exist"
else
echo "done."
fi

iter_num=$(($iter_num+1))

done

gzip /opt/backup.tar
