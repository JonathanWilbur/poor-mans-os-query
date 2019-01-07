#!/bin/sh
OUTPUT_FOLDER=poor_mans_os_query
#See this: http://rpm.org/user_doc/query_format.html
echo "INSERT INTO InstalledRPMPackages (hostname, name, version, releaseTag, epoch, summary, description, buildtime, buildhost, installtime, longarchivesize, longfilesizes, longsigsize, size) VALUES " >> rpms.sql
rpm -qa --queryformat "\t(-|_$HOSTNAME-|_, -|_%{name}-|_, -|_%{version}-|_, -|_%{release}-|_, -|_%{epoch}-|_, -|_%{summary}-|_, -|_%{description}-|_, FROM_UNIXTIME(%{buildtime}), -|_%{buildhost}-|_, FROM_UNIXTIME(%{installtime}), %{longarchivesize}, %{longfilesizes}, %{longsigsize}, %{longsize}),\n" >> rpms.sql
sed -i "s/'/''/g" rpms.sql # This doubles up the single quotes
sed -i "s/\-|_/'/g" rpms.sql # This converts the -|_ to single quotes
sed -i '$ s/.$//' rpms.sql # This removes the trailing newline and comma
sed -i "s/'(none)'/NULL/g" rpms.sql
sed -i "s/(none)/NULL/g" rpms.sql
echo ";" >> rpms.sql