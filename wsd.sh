#!/bin/bash

BASEDIR=/root/public_mm
WSD=$BASEDIR
SERVERDIR=$WSD/WSD_Server
JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64/
JAVA=java
JAR_FILE=$SERVERDIR/lib/metamapwsd.jar:$SERVERDIR/lib/utils.jar:$SERVERDIR/lib/lucene-core-3.0.1.jar:$SERVERDIR/lib/monq-1.1.1.jar:$SERVERDIR/lib/wsd.jar:$SERVERDIR/lib/kss-api.jar:$SERVERDIR/lib/thirdparty.jar:$SERVERDIR/lib/db.jar:$SERVERDIR/lib/log4j-1.2.8.jar
JVMOPTIONS="-Xmx2g -Dserver.config.file=$SERVERDIR/config/disambServer.cfg"
LD_LIBRARY_PATH=$SERVERDIR/lib:/usr/lib:$LD_LIBRARY_PATH

export LD_LIBRARY_PATH

PID_FILE=$SERVERDIR/log/pid

DAEMON="$JAVA $JVMOPTIONS -classpath $JAR_FILE wsd.server.DisambiguatorServer"
prog=wsdserverctl

config () {
        if [ ! -f $SERVERDIR/log/WSD_Server.log ]; then
                touch $SERVERDIR/log/WSD_Server.log
        fi
}

echo "Starting $prog..."

config

cd $SERVERDIR

# $DAEMON & echo $! > $PID_FILE
$DAEMON
