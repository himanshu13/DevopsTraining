#!/bin/bash	

#read input information from config file
function readConfigFile() {
 while read LINE
  do
   ARRAY=($(echo "$LINE"| /usr/bin/cut -d " " -f 1-))

   PATH=${ARRAY[0]}
   PATTERN=${ARRAY[1]}
   DAYS=${ARRAY[2]}

   findFile $PATH $PATTERN $DAYS

 done < $1
}


#find the file on specified path and delete it
function findFile() {
	echo "Deleting files at location" $1 " which are following pattern" $2 "and are" $3 "days old!"
	echo 'Following file(s) is/are being deleted:'
	echo `eval /usr/bin/find $1 -name $2 -mtime +$3`
	eval /usr/bin/find $1 -name $2 -mtime +$3 -exec /bin/rm -rf {} +
	echo -e 'Files successfully deleted! \n'
}

#call the readConfigFile function which will initiate the script
readConfigFile $1
