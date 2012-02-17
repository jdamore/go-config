#!/bin/bash

PRODUCTION_MODE=${PRODUCTION_MODE:-"Y"}

if [ "$PRODUCTION_MODE" == "Y" ]; then
    if [ -f /etc/default/go-agent ]; then
        echo "[`date`] using default settings from /etc/default/go-agent"
        . /etc/default/go-agent
    fi
fi

CWD=`dirname "$0"`
AGENT_DIR=`(cd "$CWD" && pwd)`

AGENT_MEM=${AGENT_MEM:-"128m"}
AGENT_MAX_MEM=${AGENT_MAX_MEM:-"256m"}
GO_SERVER=${GO_SERVER:-"127.0.0.1"}
GO_SERVER_PORT=${GO_SERVER_PORT:-"8153"}
JVM_DEBUG_PORT=${JVM_DEBUG_PORT:-"5006"}
JAVA_HOME=${JAVA_HOME:-"/usr"}
VNC=${VNC:-"N"}

#If this script is launched to start testing agent by production agent while running twist test, the variable
# AGENT_WORK_DIR is already set by the production agent. But testing agent should not use that.

if [ "$PRODUCTION_MODE" == "Y" ]; then
    AGENT_WORK_DIR=${AGENT_WORK_DIR:-"$AGENT_DIR"}
else
    AGENT_WORK_DIR=$AGENT_DIR
fi

if [ "$PRODUCTION_MODE" == "Y" ]; then
    if [ -d /var/log/go-agent ]; then
        LOG_FILE=/var/log/go-agent/agent-bootstrapper.log
    else
		LOG_FILE=$AGENT_WORK_DIR/agent-bootstrapper.log
	fi
else
    LOG_FILE=$AGENT_WORK_DIR/agent-bootstrapper.log
fi

if [ "$PID_FILE" ]; then
    echo "[`date`] Use PID_FILE: $PID_FILE"
elif [ "$PRODUCTION_MODE" == "Y" ]; then
    if [ -d /var/run/go-agent ]; then
        PID_FILE=/var/run/go-agent/go-agent.pid
	else
    	PID_FILE="$AGENT_WORK_DIR/go-agent.pid"
    fi
else
    PID_FILE="$AGENT_WORK_DIR/go-agent.pid"
fi

if [ "$VNC" == "Y" ]; then
    echo "[`date`] Starting up VNC on :3"
    /usr/bin/vncserver :3
    DISPLAY=:3
    export DISPLAY
fi

if [ "$JVM_DEBUG" != "" ]; then
    JVM_DEBUG="-Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=n,address=${JVM_DEBUG_PORT}"
else
    JVM_DEBUG=""
fi

AGENT_STARTUP_ARGS="-Xms$AGENT_MEM -Xmx$AGENT_MAX_MEM $JVM_DEBUG $GO_AGENT_SYSTEM_PROPERTIES -Dcruise.console.publish.interval=10"
export AGENT_STARTUP_ARGS
export LOG_FILE

CMD="$JAVA_HOME/bin/java -jar \"$AGENT_DIR/agent-bootstrapper.jar\" $GO_SERVER $GO_SERVER_PORT"

echo "[`date`] Starting with command: $CMD" >>$LOG_FILE
echo "[`date`] Starting in directory: $AGENT_WORK_DIR" >>$LOG_FILE
echo "[`date`] AGENT_STARTUP_ARGS=$AGENT_STARTUP_ARGS" >>$LOG_FILE
cd "$AGENT_WORK_DIR"

if [ "$DAEMON" == "Y" ]; then
    eval "nohup $CMD >>$LOG_FILE &"
    echo $! >$PID_FILE
else
    eval "$CMD"
fi

