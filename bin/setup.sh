#!/bin/bash

function abort()
{
	echo "Aborting!"
	exit
}

function sure()
{
	read -r -p "Are you sure you want to continue? [y/N] " response
	response=${response,,}    # tolower
	if [[ ! $response =~ ^(yes|y)$ ]]; then
		abort
	fi
}

DIR=$(readlink -f  "$(dirname "${BASH_SOURCE[0]}" )")
HM=$(readlink -f "$DIR/../home/")
DEST=${HOME}


echo "\
#######################################################
#        The Life Tectonic XSEDE setup script         #
#######################################################

READ CAREFULLY!

This script will setup your environment like one that
The Life Tectonic scripts and utilities expects for an
XSEDE system.

This may destroy a signfiicant portion of customizations
made to your environment.  You should carefully consider
if this is what you want to do before proceding. 

If you have any doubts the look in:
${HM}

The contents of this directory will be copied to your 
home directory:
${DEST}

"

sure

. $HM/lib/sh/tlt-functions

detect_system
if [ -z "$XSEDE_SYSTEM" ]; then
	echo "Unknown XSDED system `hostname`"
	abort
fi

echo "Setup detected XSEDE system \"${XSEDE_SYSTEM}\"
if this is incorrect please abort.
"
sure

echo ":: cp -av $HM/. $DEST"
cp -av $HM/. $DEST

find $DEST -name "*.${XSEDE_SYSTEM}" -print0 | while read -d $'\0' file
do
	echo ":: ln -s $(basename ${file}) ${file%.${XSEDE_SYSTEM}}"
	ln -s $(basename ${file}) ${file%.${XSEDE_SYSTEM}}
done

#
# Setup the scratch directory
#

if [ -n "$SCRATCHDIR" ]; then
	echo ":: ln -s ${SCRATCHDIR} ${HOME}/scratch"
	ln -s ${SCRATCHDIR} ${HOME}/scratch
fi

if [ -n "${SCRATCH}" ]; then
	echo ":: ln -s ${SCRATCH} ${HOME}/scratch"
	ln -s ${SCRATCH} ${HOME}/scratch
fi

#
# Setup the XSEDE_ACCOUNT
#
echo -n "Enter your XSEDE allocation account number: "
read xsede_account
echo "XSEDE_ACCOUNT=${xsede_account}" > ${HOME}/.xsede_account
echo "export XSEDE_ACCOUNT" >> ${HOME}/.xsede_account

echo -n "Enter your notification email address (press enter for no notifications): "
read xsede_email
echo "XSEDE_EMAIL=${xsede_email}" >> ${HOME}/.xsede_account
echo "export XSEDE_EMAIL" >> ${HOME}/.xsede_account

if [ -n "$xsede_email" ]; then
	if [ "$XSEDE_SYSTEM" = "stampede" ]; then
		echo -n "Enter your notification preferences, one of BEGIN, END, FAIL, ALL: "
		read xsede_notification
		echo "XSEDE_NOTIFICATION='--mail-user=${xsede_email} --mail-type=${xsede_notification}'" >> ${HOME}/.xsede_account
		echo "export XSEDE_NOTIFICATION" >> ${HOME}/.xsede_account
	elif [ "$XSEDE_SYSTEM" = "kraken" ]; then
		echo -n "Enter your notification preferences, a combination of (a)bort, (b)egin, (e)nd: "
		read xsede_notification
		echo "XSEDE_NOTIFICATION=-M ${xsede_email} -m ${xsede_notification}" >> ${HOME}/.xsede_account
		echo "export XSEDE_NOTIFICATION" >> ${HOME}/.xsede_account
	fi
fi
