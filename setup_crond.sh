#!/bin/sh

yum install -y vixie-cron

cat <<EOF > /etc/supervisord.d/crond.conf
[program:crond]
command=/bin/bash -c "source /etc/sysconfig/crond && exec /usr/sbin/crond -n $CRONDARGS"
process_name=%(program_name)s
numprocs=1
directory=/tmp
umask=022
priority=999
autostart=true
autorestart=true
startsecs=10
startretries=3
exitcodes=0,2
stopsignal=TERM
stopwaitsecs=10
user=root
EOF
