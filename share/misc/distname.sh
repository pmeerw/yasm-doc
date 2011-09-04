#!/bin/sh
# Determine OS platform
UNAME=$(uname)
DISTRO=
# If Linux, try to determine specific distribution
if [ X"$UNAME" = X"Linux" ]; then
    # If available, use LSB to identify distribution
    if [ -f /etc/lsb-release -o -d /etc/lsb-release.d ]; then
        DISTRO=$(lsb_release -i | cut -d: -f2 | sed s/'^\t'//)
    # Otherwise, use release info file
    else
        DISTRO=$(ls -d /etc/[A-Za-z]*[_-][rv]e[lr]* | grep -v "lsb" | cut -d'/' -f3 | cut -d'-' -f1 | cut -d'_' -f1)
    fi
fi
# For everything else (or if above failed), just use generic identifier
if [ X"$DISTRO" = X"" ]; then
    DISTRO=$UNAME
fi
echo $DISTRO
