#!/bin/bash
TARGET=$1
ROOTDIR=$(pwd)

if ! [ -d $ROOTDIR/lib ]; then
    mkdir lib
fi

echo -n "Downloading Libs for $TARGET... "

TEMPDIR=$ROOTDIR/temp/$TARGET
LIBDIR=$ROOTDIR/lib/$TARGET

mkdir -p $ROOTDIR/temp
mkdir -p $LIBDIR

if [ $TARGET = "linux" ]; then
	echo "Lol! nothing to do here, because Linux is awesome"
elif [ $TARGET = "windows" ]; then
    if [ `ls $LIBDIR | wc -l` == 0 ]; then
		wget https://bitbucket.org/rude/love/downloads/love-0.9.1-win64.zip -O temp/windows.zip
		unzip $ROOTDIR/temp/$TARGET -d $LIBDIR/
        if [ `ls $LIBDIR | wc -l` == 1 ]; then 
          SUBDIR=$(ls $LIBDIR)
          mv $LIBDIR/$SUBDIR/* $LIBDIR/
          rm -r $LIBDIR/$SUBDIR
        fi
    fi
elif [ $TARGET = "osx" ]; then
    if [ `ls $LIBDIR | wc -l` == 0 ]; then
		wget https://bitbucket.org/rude/love/downloads/love-0.9.1-macosx-x64.zip -O temp/osx.zip
		unzip $ROOTDIR/temp/$TARGET -d $LIBDIR/
        rm -r $LIBDIR/__MACOSX
    fi
else
	echo "ERROR: Unknown target: $TARGET"
    rm -r $LIBDIR
    rm -r $ROOTDIR/temp
	exit 1
fi

rm -r $ROOTDIR/temp

echo "DONE"
