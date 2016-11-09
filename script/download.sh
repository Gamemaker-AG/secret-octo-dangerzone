#!/bin/bash
TARGET=$1
ROOTDIR=$(pwd)

if ! [ -d $ROOTDIR/lib ]; then
    mkdir lib
fi

echo -n "Downloading Libs for $TARGET... "
echo ""

TEMPDIR=$ROOTDIR/temp/$TARGET
LIBDIR=$ROOTDIR/lib/$TARGET

mkdir -p $ROOTDIR/temp
mkdir -p $LIBDIR

if [ $TARGET = "windows" ]; then
    if [ `ls -A $LIBDIR | wc -w` == 0 ]; then
        wget -q https://bitbucket.org/rude/love/downloads/love-0.10.2-win64.zip -O temp/windows.zip
        unzip -q $ROOTDIR/temp/$TARGET -d $LIBDIR/
        SUBDIR=$(ls $LIBDIR)
        mv $LIBDIR/$SUBDIR/* $LIBDIR/
        rm -r $LIBDIR/$SUBDIR
    else
        echo "No download needed, already existing"
        echo ""
        exit 0
    fi
elif [ $TARGET = "osx" ]; then
    if [ `ls -A $LIBDIR | wc -w` == 0 ]; then
        wget -q https://bitbucket.org/rude/love/downloads/love-0.10.2-macosx-x64.zip -O temp/osx.zip
        unzip -q $ROOTDIR/temp/$TARGET -d $LIBDIR/
        rm -rf $LIBDIR/__MACOSX
    else
        echo "No download needed, already existing"
        echo ""
        exit 0
    fi
elif [ $TARGET != "linux" ]; then
	echo "ERROR: Unknown target: $TARGET "
    rm -r $LIBDIR
    rm -r $ROOTDIR/temp
	exit 1
fi

rm -r $ROOTDIR/temp

echo "$TARGET download finished"
echo ""
