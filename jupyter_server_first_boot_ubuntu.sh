#!/bin/bash
FLAG="/var/log/firstboot_jupyter.log"
USER_HOME=$(getent passwd $SUDO_USER | cut -d: -f6)
USER_NAME=$SUDO_USER
external_host = $(hostname -f | sed "s/internal$/amazonaws.com/")


if [ ! -f $FLAG ]; then
    echo "installing configured jupyter server. This may take a while."
    echo "deb http://cran-mirror.cs.uu.nl/bin/linux/ubuntu trusty/" >> /etc/apt/sources.list
    apt-get -y update
    apt-get -y install r-base
    apt-get -y install python3-pip
    pip3 install --upgrade pip
    apt-get -y install python3-dev
    apt-get -y install libfreetype6 libfreetype6-dev
    apt-get -y install libpng12-0 libpng12-dev
    apt-get -y install python3-numpy python3-scipy python3-matplotlib python3-pandas
    apt-get -y install python3-nose ipython3
    sudo -H pip3 install sympy jupyter
    PATH=$PATH:/usr/local/bin
    export PATH
    mkdir $USER_HOME/.jupyter
    chown $USER_NAME:$USER_NAME $USER_HOME/.jupyter
    touch $USER_HOME/.jupyter/jupyter_notebook_config.py
    chown $USER_NAME:$USER_NAME $USER_HOME/.jupyter/jupyter_notebook_config.py
    wget https://dl.eff.org/certbot-auto
    chmod a+x certbot-auto
    printf 'NL\nNOORDHOLLAND\nAMSTERDAM\nME\nAWESOMESECTION\nLEO\nFAKE@SERVER.COM\n' | openssl req -x509 -nodes -days 365 -newkey rsa:1024 -keyout $USER_HOME/.jupyter/sign.key -out $USER_HOME/.jupyter/sign.pem
    touch $FLAG
else
    echo "No jupyter installation needed"
fi
