#!/bin/sh

java -Dhsqldb.method_class_names="io.github.xjrga.databaselp.*" -cp '../lib/hsqldb-2.7.3.jar:../lib/commons-math3-3.6.1.jar:../lib/databaseLP-05.jar' org.hsqldb.server.Server --database.0 mem:. --dbname.0 database
