#!/bin/bash
FLAG="/var/log/firstboot_jupyter.log"
USER_HOME=$(getent passwd $SUDO_USER | cut -d: -f6)
USER_NAME=$SUDO_USER
if [ ! -f $FLAG ]; then
    echo "installing configured jupyter server. This may take a while."
    apt-get -y update
    apt-get -y install python3
    apt-get -y install python3-pip
    pip3 install --upgrade pip
    apt-get -y install python3-devel
    apt-get -y install gcc
    apt-get -y install g++
    apt-get -y install libfreetype6 libfreetype6-dev
    apt-get -y install libpng12-0 libpng12-devel
    /usr/local/bin/pip3 install numpy scipy matplotlib pandas sympy nose ipython jupyter
    PATH=$PATH:/usr/local/bin
    export PATH
    mkdir $USER_HOME/.jupyter
    chown $USER_NAME:$USER_NAME $USER_HOME/.jupyter
    touch $USER_HOME/.jupyter/jupyter_notebook_config.py
    chown $USER_NAME:$USER_NAME $USER_HOME/.jupyter/jupyter_notebook_config.py
    wget https://dl.eff.org/certbot-auto
    chmod a+x certbot-auto
    ./certbot-auto


    printf 'NL\nNOORDHOLLAND\nAMSTERDAM\nME\nAWESOMESECTION\nLEO\nFAKE@SERVER.COM\n' | openssl req -x509 -nodes -days 365 -newkey rsa:1024 -keyout $USER_HOME/.jupyter/sign.key -out $USER_HOME/.jupyter/sign.pem
    touch $FLAG
else
    echo "No jupyter installation needed"
fi
