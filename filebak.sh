#!/bin/bash
year=$(date -d "1 days ago" +%Y)
month=$(date -d "1 days ago" +%m)
day=$(date -d "1 days ago" +%d)
echo $day
if [  -e /storage/data/$year/$month/$day ]
then
    if [ ! -e /mnt/data/$year/$month ]
    then
        mkdir -p /mnt/data/$year/$month/
        echo "mkdir"
    fi

    cp -rp /storage/data/$year/$month/$day /mnt/data/$year/$month/
    if [ ! -e /mnt/data/$year/$month/$day/ ]
    then
       coment="/storage/data/$year/$month/$day:backup faild"
       echo -e "$coment" | mail -s " fileserver backup failed"  bill.duan@saninco.com
       exit 1
    else
         oldFolder=$(du /storage/data/$year/$month/$day/ | awk '{print $1}')
         newFolder=$(du /mnt/data/$year/$month/$day/ | awk '{print $1}')
         if [ $oldFolder != $newFolder ]
         then
            coment="/storage/data/$year/$month/$day:backup faild"
            echo -e "$coment" | mail -s " fileserver backup failed"  bill.duan@saninco.com
            exit 1
         fi
    fi

else
    echo "folder not found"


fi
