#!/bin/sh
#
# This file should be sourced before doing work in the compare-codecs
# environment.
#

# Function to remove duplicate path entries - to make running this file
# twice not grow the path. It also trims leading colons.
dedup() {
  echo $1 | awk -F: '{for (i=1;i<=NF;i++) { if ( $i != "" && !x[$i]++ ) printf("%s:",$i); }}' | sed -e 's/:*$//'
}

if [ ! -f init.sh ]; then
  echo "This init file must be sourced while in its own directory"
  exit 1
fi

export WORKDIR="$(cd "$(dirname "$0")" && pwd)"
PATH=$(dedup "$PATH:$WORKDIR/bin")
export PYTHONPATH=$(dedup "$PYTHONPATH:$WORKDIR/lib")
export CODEC_WORKDIR=$WORKDIR/workdir
export CODEC_TOOLPATH=$WORKDIR/vpx_codec_comparison/bin

if [ ! -d $CODEC_WORKDIR ]; then
  mkdir $CODEC_WORKDIR
fi
