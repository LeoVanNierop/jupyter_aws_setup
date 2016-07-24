#!/bin/bash
FLAG="/var/log/firstboot_jupyter.log"
USER_HOME=$(getent passwd $SUDO_USER | cut -d: -f6)
if [ ! -f $FLAG ]; then
    echo "installing configured jupyter server. This may take a while."
    yum -y update
    yum -y install python34
    yum -y install python34-pip
    pip-3.4 install --upgrade pip
    yum -y install python34-devel
    yum -y install gcc
    yum -y install gcc-c++
    yum -y install freetype freetype-devel
    yum -y install libpng libpng-devel
    /usr/local/bin/pip3 install numpy scipy matplotlib pandas sympy nose ipython jupyter
    PATH=$PATH:/usr/local/bin
    export PATH
    mkdir $USER_HOME/.jupyter
    touch $USER_HOME/.jupyter/jupyter_notebook_config.py
    printf 'NL\nNOORDHOLLAND\nAMSTERDAM\nME\nAWESOMESECTION\nLEO\nFAKE@SERVER.COM\n' | openssl req -x509 -nodes -days 365 -newkey rsa:1024 -keyout $USER_HOME/.jupyter/sign.key -out $USER_HOME/.jupyter/sign.pem
    touch $FLAG
else
    echo "No jupyter installation needed"
fi
