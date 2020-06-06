#!/bin/sh
schematool -validate -dbType postgres
if [ "$?" -ne "0" ]
then
    schematool -initSchema -dbType postgres
fi
hive --service metastore & hive --service hiveserver2