#!/usr/bin/env python

"""
Mini script to kill jobs of one user by the name of the jobs. Usage:

qdel_name_user.py --user <username> --name <job_name>


---------------------
Install dependencies:

pip install qstat
"""

import argparse
import os
import pandas as pd
import numpy as np
from qstat import qstat

if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument("--user", "-u", required=True)
    parser.add_argument("--name", "-n", required=True)

    args = parser.parse_args()
    queue_info, job_info = qstat()
    qstat_out = pd.DataFrame(queue_info + job_info)

    jobs_to_delete = qstat_out[(qstat_out.JB_owner == args.user) &
                               (qstat_out.JB_name == args.name)].JB_job_number.to_numpy(int)

    qdel_command = f"qdel {np.array2string(jobs_to_delete, max_line_width=np.inf)[1:-1]}"
    print(qdel_command)
    os.system(qdel_command)
