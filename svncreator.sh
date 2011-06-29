#!/bin/bash
# su - svn
# cd repositories
# svnadmin create $1
# echo "
# [general]
# # anon-access = read
# # auth-access = write
# # password-db = passwd
# # authz-db = authz
# # realm = My First Repository
# auth-access = write
# password-db = passwd
# [sasl]
# # use-sasl = true
# " > /home/svn/repositories/$1/conf/svnserve.conf
# cat /home/svn/passwd-devs > /home/svn/repositories/$1/conf/passwd
ls
mkdir $1
exit
