#!/bin/bash -e

POLLING_FREQ=${POLLING_FREQ:-"* * * * *"}

# No logrotate
rm /etc/cron.daily/logrotate

# Make sure the cleaning works
/clean.sh

touch /var/log/update.log
echo "$POLLING_FREQ /clean.sh >> /var/log/cleaning.log 2>&1" | crontab -

rsyslogd
cron
CRON_PID=$!
tail -f /var/log/syslog &
tail -f /var/log/cleaning.log

