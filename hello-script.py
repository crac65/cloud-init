#!/usr/bin/python3

print ("Hello form python")

import pexpect
import os

password = "paword2023"

(output, status) = pexpect.run(
    "/opt/emc/boostfs/bin/boostfs lockbox set -u boost_caas -d 10.1.1.196 -s stu_caas",
    withexitstatus=True,
    encoding='utf8',
    events={ "Enter storage unit user password": password + '\n' }
)

os.system('mkdir /mnt/testbackup')
os.system('/opt/emc/boostfs/bin/boostfs  mount -d 10.1.1.196 -s stu_caas /mnt/testbackup')

if status == 0:
    print("it worked!")
else:
    print("it didn't work -- status code was ", status)
    print(output)
