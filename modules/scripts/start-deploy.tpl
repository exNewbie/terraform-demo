#!/bin/bash

LOG_FILE="/var/log/deploy.log";
AWS_CLI="aws";
USER="app";
GROUP="apache";

write_log() {
  now=$( date +"%Y-%m-%d %H:%m:%S %z" );
  echo "$now [$1] $2" >> $LOG_FILE;
}

################################################################################

if [ ! -f $LOG_FILE ]; then
  touch $LOG_FILE;
fi

write_log "INFO" "$0 starting...";

write_log "INFO" "$0 Install packages";
yum update -y;
amazon-linux-extras install -y nginx1.12;

write_log "INFO" "$0 Write instance ID to index.html file";
curl http://169.254.169.254/latest/meta-data/instance-id > /usr/share/nginx/html/index.html;

write_log "INFO" "$0 Start web server";
systemctl restart nginx;

write_log "INFO" "$0 finished...";
