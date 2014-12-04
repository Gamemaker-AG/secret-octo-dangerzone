#!/bin/bash
rootdir=$(pwd)

# Creating Tempdir
mkdir -p temp
tempdir=$rootdir/temp
componentdir=$tempdir/components

# Copying source to tempdir
cp -r $rootdir/src/* $tempdir

# Setting Counter for naming
counter=1


find $componentdir -type f | while read path; do
    # Getting classname
    p=$path
    xpath=${p%/*} 
    xbase=${p##*/}
    xfext=${xbase##*.}
    xpref=${xbase%.*}
    echo "Replacing $xpref"

    sedcommand='s/"'
    sedcommand+=$xpref
    sedcommand+='"/'
    sedcommand+=$counter
    sedcommand+='/g'

    echo $sedcommand
    echo ""

    sed -i $sedcommand $(grep --binary-files=without-match -rl $xpref $tempdir)
    counter=$((counter+1))
done
echo ""
echo "All Componentnames replaced"
echo ""
