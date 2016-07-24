#!/bin/bash
FLAG="/var/log/firstboot_jupyter.log"
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
    sudo -u $SUDO_USER jupyter notebook --generate-config
    sudo -u $SUDO_USER openssl req -x509 -nodes -days 365 -newkey rsa:1024 -keyout ~/.jupyter/sign.key -out ~/.jupyter/sign.pem
    touch $FLAG
else
    echo "No jupyter installation needed"
fi
