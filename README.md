# jupyter_aws_setup
A few scripts that set up a jupyter notebook server on an aws instance running aws linux, basically following http://jupyter-notebook.readthedocs.io/en/latest/public_server.html
This is using a self-signed ssl certificate, which means that your browser will complain that it is not secure. I may fix that later, but for now that is what it is.

NOTE: YOU PROBABLY WANT TO CHANGE THE ANSWERS TO THE SECURITY CERTIFICATE QUESTIONS BEFORE RUNNING THE FIRST SCRIPT (LINE 20, THE PRINTF STRING) Using publicly known answers means that an attacker can recreate the credentials for a man in the middle attack

If you want to learn how to do this, follow a proper tutorial. If, however, you cannot be bothered, do this:
1) Launch an aws instance, make sure that the security group allows http connections on port 9999
2) ssh in and run:

 sudo yum -y install git
 
 git clone https://github.com/LeoVanNierop/jupyter_aws_setup.git
 
 cd jupyter_aws_setup
 
 sudo ./jupyter_server_first_boot.sh
 
Go get a coffee, this is going to take a while (approx. 5 minutes on a free tier micro instance)

run:

./setup_notebook_config.py

nohup jupyter notebook &

open your browser and go to

https://(your aws instance public dns):9999

 
