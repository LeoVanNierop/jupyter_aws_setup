#!/bin/bash
FLAG="/var/log/firstboot_jupyter.log"


if [ ! -f $FLAG ]; then
    echo "installing configured jupyter server. This may take a while."
    echo "deb http://cran-mirror.cs.uu.nl/bin/linux/ubuntu trusty/" | sudo tee -a /etc/apt/sources.list
    sudo -H apt-get -y --force-yes update
    sudo -H apt-get -y --force-yes install r-base
    sudo -H apt-get -y --force-yes install python3-pip
    sudo -H apt-get -y --force-yes install libfreetype6 libfreetype6-dev
    sudo -H apt-get -y --force-yes install libpng12-0 libpng12-dev
    sudo -H apt-get -y --force-yes install python3-numpy python3-scipy python3-matplotlib python3-pandas
    sudo -H apt-get -y --force-yes install python3-nose ipython3
    sudo pip3 install sympy jupyter
    mkdir ~/.jupyter/
    touch ~/.jupyter/jupyter_notebook_config.py
    wget https://dl.eff.org/certbot-auto
    chmod a+x certbot-auto
    sudo touch $FLAG
else
    echo "No jupyter installation needed"
fi