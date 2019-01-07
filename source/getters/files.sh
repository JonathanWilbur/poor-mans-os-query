#!/bin/sh
OUTPUT_FOLDER=poor_mans_os_query
echo "INSERT INTO Files (hostname, directory, fileName, inodeNumber, depth, userID, groupID, lastAccessTime, lastModifyTime, creationTime, sizeInBytes, deviceNumber, fileSystemType, objectOfSymbolicLink, fileType, mode, selinuxContext) VALUES " > ${OUTPUT_FOLDER}/files.sql

which selinuxenabled
if [ $? -eq 0 ]; then
    selinuxenabled
fi

# TODO: Select only non-directories
# TODO: Get Hashes
if [ $? -eq 0 ]; then # If SELinux is enabled
    find / \( -path /proc -o -path /sys \) -prune -o -printf "\t('${HOSTNAME}', '%h', '%f', %i, %d, %U, %G, FROM_UNIXTIME(%A@), FROM_UNIXTIME(%T@), FROM_UNIXTIME(%C@), %s, %D, '%F', '%l', '%y', '%m', '%Z'),\n" >> ${OUTPUT_FOLDER}/files.sql
elif
    find / \( -path /proc -o -path /sys \) -prune -o -printf "\t('${HOSTNAME}', '%h', '%f', %i, %d, %U, %G, FROM_UNIXTIME(%A@), FROM_UNIXTIME(%T@), FROM_UNIXTIME(%C@), %s, %D, '%F', '%l', '%y', '%m', NULL),\n" >> ${OUTPUT_FOLDER}/files.sql
fi
sed -i '$ s/.$//' ${OUTPUT_FOLDER}/files.sql # This removes the trailing newline and comma
echo ";" >> ${OUTPUT_FOLDER}/files.sql