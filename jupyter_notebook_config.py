import subprocess
from datetime import datetime
import os
from notebook.auth.logout import LogoutHandler
from notebook.auth.login import LoginHandler

c = get_config()

c.NotebookApp.ip = '*'
c.NotebookApp.open_browser = False
c.NotebookApp.port = 9999

class PushOnLogoutHandler(LogoutHandler):
    def get(self):
        message = '"jupyter auto save at {}"'.format(datetime.now())
        try:
            subprocess.check_call(['git', 'add', '-A'], cwd=c.NotebookApp.notebook_dir)
            subprocess.check_call(['git', 'commit', '-am', message], cwd=c.NotebookApp.notebook_dir)
            subprocess.check_call(['git', 'push'], cwd=c.NotebookApp.notebook_dir)
        except:
            pass
        super().get()

c.NotebookApp.logout_handler_class = PushOnLogoutHandler

class PullOnLoginHandler(LoginHandler):
    #We initiate a git pull if authentication passes: upon redirect
    def redirect(self, url, permanent=False, status=None):
        subprocess.check_call(['git', 'pull', '-X', 'ours'], cwd=c.NotebookApp.notebook_dir)
        super().redirect()




def scrub_output_pre_save(model, **kwargs):
    """scrub output before saving notebooks"""
    # only run on notebooks
    if model['type'] != 'notebook':
        return
    # only run on nbformat v4
    if model['content']['nbformat'] != 4:
        return

    for cell in model['content']['cells']:
        if cell['cell_type'] != 'code':
            continue
        cell['outputs'] = []
        cell['execution_count'] = None

c.FileContentsManager.pre_save_hook = scrub_output_pre_save


def convert_post_save(model, os_path, **kwargs):
    #make sure you set up a good gitignore. Also look at git pre-commit hook for stripping output
    if model['type'] != 'notebook':
        return

    d, fname = os.path.split(os_path)
    subprocess.check_call(['jupyter', 'nbconvert', '--to', 'script', fname], cwd=d)
    subprocess.check_call(['jupyter', 'nbconvert', '--to', 'html', fname], cwd=d)



c.FileContentsManager.post_save_hook = convert_post_save