#!/usr/bin/env bash

set -e

HELP_TEXT="./Build.sh <example> [run|debug]"

RUN_EXAMPLE=0
DEBUG_EXAMPLE=0

if [ -z "Examples/$1" ]; then
    echo $HELP_TEXT
    exit 1
fi

if [ ! -d "Examples/$1" ]; then
    echo "'Examples/$1' example folder does not exist"
    exit 1
fi

if [ "$2" = "debug" ]; then
    DEBUG_EXAMPLE=1
elif [ "$2" = "run" ]; then
    RUN_EXAMPLE=1
elif [ ! -z "$2" ]; then
    echo $HELP_TEXT
    exit 1
fi

SHARED_FLAGS=" "
SHARED_FLAGS+="-std=c99 "
SHARED_FLAGS+="-pedantic "
SHARED_FLAGS+="-Wall "
SHARED_FLAGS+="-Wextra "
SHARED_FLAGS+="-Wconversion "
SHARED_FLAGS+="-Wno-unused-label "
SHARED_FLAGS+="-Werror "
SHARED_FLAGS+="-lSDL2 "

SHARED_FLAGS+="-DFUN_EXAMPLE_NAME=\"$1\""

if [ $DEBUG_EXAMPLE -gt 0 ]; then
    SHARED_FLAGS+="-g "
fi

cc $SHARED_FLAGS \
   $CFLAGS       \
   "Examples/$1/$1.c" -o "Examples/$1/$1.example"

if [ $DEBUG_EXAMPLE -gt 0 ]; then
    lldb -o run "Examples/$1/$1.example"
elif [ $RUN_EXAMPLE -gt 0 ]; then
    ./"Examples/$1/$1.example"
fi
