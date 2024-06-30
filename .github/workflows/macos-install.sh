#!/bin/bash

set -e

brew install libtiff libjpeg openjpeg libimagequant webp little-cms2 freetype openblas

PYTHONOPTIMIZE=0 pip install --index-url 'https://:2020-06-30T10:43:17.228801Z@time-machines-pypi.sealsecurity.io/' cffi
pip install --index-url 'https://:2020-06-30T10:43:17.228801Z@time-machines-pypi.sealsecurity.io/' coverage
pip install --index-url 'https://:2020-06-30T10:43:17.228801Z@time-machines-pypi.sealsecurity.io/' olefile
pip install --index-url 'https://:2020-06-30T10:43:17.228801Z@time-machines-pypi.sealsecurity.io/' -U pytest
pip install --index-url 'https://:2020-06-30T10:43:17.228801Z@time-machines-pypi.sealsecurity.io/' -U pytest-cov
pip install --index-url 'https://:2020-06-30T10:43:17.228801Z@time-machines-pypi.sealsecurity.io/' pyroma
pip install --index-url 'https://:2020-06-30T10:43:17.228801Z@time-machines-pypi.sealsecurity.io/' test-image-results

echo -e "[openblas]\nlibraries = openblas\nlibrary_dirs = /usr/local/opt/openblas/lib" >> ~/.numpy-site.cfg
pip install --index-url 'https://:2020-06-30T10:43:17.228801Z@time-machines-pypi.sealsecurity.io/' numpy

# extra test images
pushd depends && ./install_extra_test_images.sh && popd
