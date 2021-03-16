# scripts_and_tools
Repository collecting useful tools and scripts for general use.

## Table of contents
- local_install_tmux.sh
  - Automatic local installation of tmux version 3.1b including required dependency without root access to the system.
  - Adding to the path for zsh shell. For do this your own. 
  - Usage: `local_install_tmux.sh <install directory>`

- qdel_name_user.py
  - Delete jobs of user by jobname. Runs qstat and finds the of the user and with the given name and runs qdel.
  - Requirement: `python>3.6`, `pandas`, `numpy`
  - Install qstat for python: `pip install qstat`
  - Usage: `qdel_name_user.py --user <username> --name <job_name>`