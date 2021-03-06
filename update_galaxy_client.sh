#!/bin/bash

usage() {
cat << EOF
Usage: ${0##*/} [-i] /path/to/galaxy...
Sync Pulsar client with copy in specified Galaxy directory (or vice versa if -i).

EOF
}

if [ $# -lt 1 ]; then
    usage
    exit 1
fi

invert=0
OPTIND=1
while getopts ":i" opt; do
    case "$opt" in
        h)
            usage
            exit 0
            ;;
        i)
            invert=1
            ;;
        '?')
            usage >&2
            exit 1
            ;;
    esac
done
shift "$((OPTIND-1))" # Shift off the options and optional --.
PULSAR_DIRECTORY="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
GALAXY_DIRECTORY=$1
GALAXY_PULSAR_DIRECTORY=$GALAXY_DIRECTORY/lib/pulsar/

if [ "$invert" -ne "1" ];
then
	rm -rf $GALAXY_PULSAR_DIRECTORY/client
	cp -r $PULSAR_DIRECTORY/pulsar/client $GALAXY_PULSAR_DIRECTORY
else
	rm -rf $PULSAR_DIRECTORY/pulsar/client
	cp -r $GALAXY_PULSAR_DIRECTORY/client $PULSAR_DIRECTORY/pulsar
fi
