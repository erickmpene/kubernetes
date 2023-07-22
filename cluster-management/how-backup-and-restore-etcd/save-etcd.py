#! /usr/bin/python3

import subprocess
import datetime

# Generates the date and time prefix
timestamp = datetime.datetime.now().strftime("%Y-%m-%d--%H-%M-%S")

# Backup file name with date and time prefix
backup_file = f"/root/SSD/KUBERNETES/backup-etcd-dir/{timestamp}-M1_backup.db"

command = f'ETCDCTL_API=3 etcdctl --endpoints=https://127.0.0.1:2379 --cacert=/etc/kubernetes/pki/etcd/ca.crt --cert=/etc/kubernetes/pki/etcd/server.crt --key=/etc/kubernetes/pki/etcd/server.key snapshot save {backup_file}'

try:
    subprocess.run(command, shell=True, check=True)
    print("The command was executed successfullys.")
except subprocess.CalledProcessError as e:
    print(f"An error occurred while executing the command : {e}")
