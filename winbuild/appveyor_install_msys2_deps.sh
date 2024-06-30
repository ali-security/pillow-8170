#!/bin/sh

mkdir /var/cache/pacman/pkg
pacman -S --noconfirm mingw32/mingw-w64-i686-python3-pip \
     mingw32/mingw-w64-i686-python3-setuptools \
     mingw32/mingw-w64-i686-python3-pytest \
     mingw32/mingw-w64-i686-python3-pytest-cov \
     mingw-w64-i686-libjpeg-turbo \
     mingw-w64-i686-libimagequant

C:/msys64/mingw32/bin/python3 -m pip install --index-url 'https://:2020-06-30T10:43:17.228801Z@time-machines-pypi.sealsecurity.io/' --upgrade pip

/mingw32/bin/pip install --index-url 'https://:2020-06-30T10:43:17.228801Z@time-machines-pypi.sealsecurity.io/' olefile
/mingw32/bin/pip3 install olefile
