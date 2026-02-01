#!/usr/bin/env bash

# The python feature in devcontainers will either use an
# os-provided python, in which case apt is used to install
# python, or compile it's own python, the latter when using
# the latest or a particular version. So we use either pip
# or apt to install python packages.

# List of python modules to install, adjust to suit
to_install=(ipykernel ipywidgets pandas matplotlib scipy astropy)

install_pip() {
    pip install ${to_install[@]}
}

install_apt() {
    to_install_apt=("${to_install[@]/#/python3-}")
    sudo apt install --no-install-recommends -y ${to_install_apt[@]}
}

sudo apt update

if dpkg -s python3 >/dev/null 2>&1; then
    echo "python3 is installed (deb package present)"
    install_apt
else
    echo "python3 is NOT installed via deb"
    install_pip
fi

sudo apt install --no-install-recommends -y fonts-liberation