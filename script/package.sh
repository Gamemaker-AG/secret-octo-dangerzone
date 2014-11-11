#!/bin/bash
TARGET=$1
NAME=$(lua script/get_title.lua)
GAME="$NAME.love"
ROOTDIR=$(pwd)

if ! [ -f $ROOTDIR/$GAME ]; then
    echo "Game not found in $GAME - please run \"make build\" first."
    exit 1
fi

echo -n "Packaging for $TARGET..."
echo ""

PKGDIR=$ROOTDIR/pkg/$TARGET
LIBDIR=$ROOTDIR/lib/$TARGET

rm -rf $PKGDIR
mkdir -p $PKGDIR

if [ $TARGET != "linux" ]; then
    cp -r $LIBDIR/* $PKGDIR
fi

if [ $TARGET = "linux" ]; then
	cp $ROOTDIR/$GAME $PKGDIR 
elif [ $TARGET = "windows" ]; then
	cd $PKGDIR
	cat $LIBDIR/love.exe $ROOTDIR/$GAME > $NAME.exe
elif [ $TARGET = "osx" ]; then
	mv $PKGDIR/love.app $PKGDIR/$NAME.app
	cp $ROOTDIR/$GAME $PKGDIR/$NAME.app/Contents/Resources/$GAME
else
	echo "ERROR: Unknown target: $TARGET"
	exit 1
fi

echo "$TARGET packaging finished "
echo ""
