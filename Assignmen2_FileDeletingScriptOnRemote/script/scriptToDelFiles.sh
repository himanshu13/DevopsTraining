#!/bin/bash	

#TODO: handle cases if unable to ssh on the specified machine. Right now the script hangs if it couldn't access the machine.

#read input information from config file
function readConfigFile() {
 while read LINE
  do 
   ARRAY=($(echo "$LINE"| /usr/bin/cut -d " " -f 1-))

   MACHINE=${ARRAY[0]}
   PATH=${ARRAY[1]}
   PATTERN=${ARRAY[2]}
   DAYS=${ARRAY[3]}

   findFile $PATH $PATTERN $DAYS $MACHINE  < /dev/null;

 done < $1;
}


#find the file on specified path and delete it
function findFile() {
	echo "Deleting files on machine" $4 "at location" $1 "which are following pattern" $2 "and are" $3 "days old!";
	echo -e 'Following file(s) is/are being deleted: \n';
	/usr/bin/ssh $4 /usr/bin/find $1 -name $2 -mtime +$3;
	eval /usr/bin/ssh $4 /usr/bin/find $1 -name $2 -mtime +$3 -exec /bin/rm -rf {} +
	echo -e '\nFiles successfully deleted! \n';
}

#call the readConfigFile function which will initiate the script
readConfigFile $1
