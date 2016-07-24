#!/usr/local/bin/ipython
from notebook.auth import passwd
import os
import sys
home = os.getenv('HOME')
notebook_dir = os.path.join(home, 'notebooks')
try:
    os.makedirs(notebook_dir)
except:
    #exists
    pass
pwd = passwd()
with open(os.path.join(home, '.jupyter/jupyter_notebook_config.py'), 'a') as f:
    f.write('c.NotebookApp.password = {}\n'.format(repr(pwd)))
    f.write("c.NotebookApp.certfile = {}\n".format(repr(os.path.join(home, '.jupyter/sign.pem'))))
    f.write("c.NotebookApp.keyfile = {}\n".format(repr(os.path.join(home, '.jupyter/sign.key'))))
    f.write("c.NotebookApp.ip = '*'\n")
    f.write("c.NotebookApp.open_browser = False\n")
    f.write("c.NotebookApp.port = 9999\n")
    f.write("c.NotebookApp.notebook_dir = {}\n".format(repr(notebook_dir)))
