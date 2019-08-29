#!/bin/bash

python_version=$1

echo "Installing ${python_version}..."

CFLAGS="-I$(xcrun --show-sdk-path)/usr/include" pyenv install $1
