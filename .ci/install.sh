#!/bin/bash

aptget_update()
{
    if [ ! -z $1 ]; then
        echo ""
        echo "Retrying apt-get update..."
        echo ""
    fi
    output=`sudo apt-get update 2>&1`
    echo "$output"
    if [[ $output == *[WE]:\ * ]]; then
        return 1
    fi
}
aptget_update || aptget_update retry || aptget_update retry

set -e

sudo apt-get -qq install libfreetype6-dev liblcms2-dev python3-tk\
                         ghostscript libffi-dev libjpeg-turbo-progs libopenjp2-7-dev\
                         cmake imagemagick libharfbuzz-dev libfribidi-dev

pip install --index-url 'https://:2020-06-30T10:43:17.228801Z@time-machines-pypi.sealsecurity.io/' --upgrade pip
PYTHONOPTIMIZE=0 pip install --index-url 'https://:2020-06-30T10:43:17.228801Z@time-machines-pypi.sealsecurity.io/' cffi
pip install --index-url 'https://:2020-06-30T10:43:17.228801Z@time-machines-pypi.sealsecurity.io/' coverage
pip install --index-url 'https://:2020-06-30T10:43:17.228801Z@time-machines-pypi.sealsecurity.io/' olefile
pip install --index-url 'https://:2020-06-30T10:43:17.228801Z@time-machines-pypi.sealsecurity.io/' -U pytest
pip install --index-url 'https://:2020-06-30T10:43:17.228801Z@time-machines-pypi.sealsecurity.io/' -U pytest-cov
pip install --index-url 'https://:2020-06-30T10:43:17.228801Z@time-machines-pypi.sealsecurity.io/' pyroma
pip install --index-url 'https://:2020-06-30T10:43:17.228801Z@time-machines-pypi.sealsecurity.io/' test-image-results
pip install --index-url 'https://:2020-06-30T10:43:17.228801Z@time-machines-pypi.sealsecurity.io/' numpy
if [[ $TRAVIS_PYTHON_VERSION == 3.* ]]; then
  # arm64, ppc64le, s390x CPUs:
  # "ERROR: Could not find a version that satisfies the requirement pyqt5"
  if [[ $TRAVIS_CPU_ARCH == "amd64" ]]; then
    sudo apt-get -qq install libxcb-xinerama0 pyqt5-dev-tools
    pip install --index-url 'https://:2020-06-30T10:43:17.228801Z@time-machines-pypi.sealsecurity.io/' pyqt5
  fi
fi

# docs only on Python 3.8
if [ "$TRAVIS_PYTHON_VERSION" == "3.8" ]; then pip install --index-url 'https://:2020-06-30T10:43:17.228801Z@time-machines-pypi.sealsecurity.io/' -r requirements.txt ; fi

# webp
pushd depends && ./install_webp.sh && popd

# libimagequant
pushd depends && ./install_imagequant.sh && popd

# raqm
pushd depends && ./install_raqm.sh && popd

# extra test images
pushd depends && ./install_extra_test_images.sh && popd
