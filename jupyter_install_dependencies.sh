#!/bin/bash
FLAG="/var/log/firstboot_jupyter.log"


if [ ! -f $FLAG ]; then
    echo "installing configured jupyter server. This may take a while."
    echo "deb http://cran-mirror.cs.uu.nl/bin/linux/ubuntu trusty/" | sudo tee -a /etc/apt/sources.list
    sudo -H apt-get -y --force-yes update
    sudo -H apt-get -y --force-yes install r-base
    sudo -H apt-get -y --force-yes install python3-pip
    pip3 install --upgrade setuptools pip
    sudo -H apt-get -y --force-yes install libssl-dev
    sudo -H apt-get -y --force-yes build-dep libcurl4-gnutls-dev
    sudo -H apt-get -y --force-yes install libcurl4-gnutls-dev
    sudo -H apt-get -y --force-yes install libfreetype6 libfreetype6-dev
    sudo -H apt-get -y --force-yes install libpng12-0 libpng12-dev
    sudo -H apt-get -y --force-yes install python3-numpy python3-scipy python3-matplotlib python3-pandas
    sudo -H apt-get -y --force-yes install python3-nose ipython3
    sudo -H pip3 install sympy jupyter
    sudo -H pipr install --upgrade numpy scipy matplotlib pandas nose ipython
    mkdir ~/.jupyter/
    mv ~/jupyter_aws_setup/jupyter_notebook_config.py ~/.jupyter/
    wget https://dl.eff.org/certbot-auto
    chmod a+x certbot-auto
    sudo chmod o+w /usr/local/lib/R/site-library
    ~/jupyter_aws_setup/setup_R_kernel.r
    #printf 'NL\nNOORDHOLLAND\nAMSTERDAM\nME\nAWESOMESECTION\nLEO\nFAKE@SERVER.COM\n' | openssl req -x509 -nodes -days 365 -newkey rsa:1024 -keyout ~/.jupyter/sign.key -out ~/.jupyter/sign.pem

    sudo touch $FLAG
else
    echo "No jupyter installation needed"
fi