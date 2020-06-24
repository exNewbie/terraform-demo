#!/bin/bash

LOG_FILE="/var/log/deploy.log";
AWS_CLI="aws";
USER="app";
GROUP="apache";
INSTANCE_ID=$(curl http://169.254.169.254/latest/meta-data/instance-id);
export AWS_DEFAULT_REGION=ap-southeast-2;

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
echo $INSTANCE_ID > /usr/share/nginx/html/index.html;

write_log "INFO" "$0 Start web server";
systemctl restart nginx;

### Continue Lifecycle hook
write_log "INFO" "$0 Send CONTINUE to Lifecycle hook...";
$AWS_CLI autoscaling complete-lifecycle-action --lifecycle-hook-name ${lifecycle_hook_launching_name} --auto-scaling-group-name ${asg_name} --lifecycle-action-result CONTINUE --instance-id $INSTANCE_ID;

write_log "INFO" "$0 finished...";
