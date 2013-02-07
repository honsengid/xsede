#!/bin/bash

function detect_system()
{
	if [[ `hostname` =~ 'stampede' ]]; then
		XSEDE_SYSTEM='stampede'
	elif [[ `hostname` =~ 'kraken' ]]; then
		XSEDE_SYSTEM='kraken'
	fi
}

detect_system
if [ -n "$XSEDE_SYSTEM" ]; then
	echo $XSEDE_SYSTEM
else
	echo "Unknown XSDED system `hostname`"
fi
