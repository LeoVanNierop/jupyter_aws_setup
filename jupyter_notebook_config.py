import subprocess
from datetime import datetime
import os

c = get_config()

c.NotebookApp.ip = '*'
c.NotebookApp.open_browser = False
c.NotebookApp.port = 9999

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


def git_push_post_save(model, os_path, **kwargs):
    #make sure you set up a good gitignore. Also look at git pre-commit hook for stripping output
    if model['type'] != 'notebook':
        return

    d, fname = os.path.split(os_path)
    subprocess.check_call(['jupyter', 'nbconvert', '--to', 'script', fname], cwd=d)
    subprocess.check_call(['jupyter', 'nbconvert', '--to', 'html', fname], cwd=d)

    message = "jupyter auto save at {}".format(datetime.now())
    subprocess.check_call(['git', 'commit', '-am', message], cwd=d)
    subprocess.check_call(['git', 'push'], cwd=d)

c.FileContentsManager.post_save_hook = git_push_post_save