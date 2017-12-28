#!/bin/bash

set -e

coverage erase
make clean
make install-coverage

coverage run --append  selftest.py
coverage run --append  -m nose -vx Tests/test_*.py
pushd /tmp/check-manifest && check-manifest --ignore ".coveragerc,.editorconfig,*.yml,*.yaml,tox.ini" && popd

# Docs
if [ "$TRAVIS_PYTHON_VERSION" == "2.7" ]; then make doccheck; fi
