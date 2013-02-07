#!/bin/bash

. $HOME/lib/sh/tlt-functions

detect_system
if [ -n "$XSEDE_SYSTEM" ]; then
	echo $XSEDE_SYSTEM
else
	echo "Unknown XSDED system `hostname`"
fi
