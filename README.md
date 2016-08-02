# jupyter_aws_setup
A few scripts that set up a jupyter notebook server on an aws instance running aws linux, basically following http://jupyter-notebook.readthedocs.io/en/latest/public_server.html
This is using a self-signed ssl certificate, which means that your browser will complain that it is not secure. I may fix that later, but for now that is what it is.

NOTE: YOU PROBABLY WANT TO CHANGE THE ANSWERS TO THE SECURITY CERTIFICATE QUESTIONS BEFORE RUNNING THE FIRST SCRIPT (LINE 20, THE PRINTF STRING) Using publicly known answers means that an attacker can recreate the credentials for a man in the middle attack

If you want to learn how to do this, follow a proper tutorial. If, however, you cannot be bothered, do this:
1) Launch an aws instance, make sure that the security group allows http connections on port 9999
2) ssh in and run:

 sudo apt-get -y install git
 
 git clone https://github.com/LeoVanNierop/jupyter_aws_setup.git
 
 cd jupyter_aws_setup
 
 ./jupyter_install_dependencies.sh
 
Go get a coffee, this is going to take a while (approx. 5 minutes on a free tier micro instance)

Get a domain name. Point it at your instance. Certbot has aws on its blacklist, so you won't get an ssl certificate without your own domain pointed at it.
For a free domain, go to www.dot.tk, and follow their instructions. NOTE: for dot.tk you need to have a server running to respond to pings. Runserver.sh is a one-line
server that just returns index.html with  a 200 status line. Have this running when you start the registration (sudo ./runserver.sh)

run:

./certificate.sh

and follow the instructions to create an ssl certificate. Currently, to get it to work, I copied the relevant key files to ~./jupyter using:

sudo copy /etc/letsencrypt/archive/(your domain name)/*.pem /home/ubuntu/.jupyter
sudo chown ubuntu:ubuntu /home/ubuntu/.jupyter/*.pem

Create a remote notebook repository, and set the upstream of ~/notebooks to it. 


to start the notebook server:
nohup start_jupyter.sh &

open your browser and go to

https://(your aws instance public dns):9999

If you want the jupyter server to start up when you start the instance after stopping it, add the following line to /etc/rc.local

su ubuntu -c "/home/ubuntu/jupyter_aws_setup/start_jupyter.sh"

