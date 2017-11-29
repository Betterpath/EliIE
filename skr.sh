#!/bin/bash

BASEDIR=/root/Tools/MetaMap/public_mm
MEDPOSTDIR=$BASEDIR/MedPost-SKR
DATADIR=$MEDPOSTDIR/data
SERVERDIR=$MEDPOSTDIR/Tagger_server
JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64/
JAVA=java
CLASSPATH=$SERVERDIR/lib/taggerServer.jar:$SERVERDIR/lib/mps.jar
PID_FILE=$SERVERDIR/log/pid
LOG_FILE=$SERVERDIR/log/log
ERR_FILE=$SERVERDIR/log/errors
LEXDBFILE=$DATADIR/lexDB.serial
NGRAMFILE=$DATADIR/ngramOne.serial
SERVERPORT=1795
JVMOPTIONS="-Dtaggerserver.port=$SERVERPORT -DlexFile=$LEXDBFILE -DngramOne=$NGRAMFILE"
DAEMON="$JAVA $JVMOPTIONS -cp $CLASSPATH taggerServer"
prog=skrmedpostctl

echo "Starting $prog..."

cd $SERVERDIR
#$DAEMON 1> $LOG_FILE 2> $ERR_FILE & echo $! > $PID_FILE

$DAEMON
