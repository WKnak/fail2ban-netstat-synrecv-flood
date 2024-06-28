#!/bin/bash
# Author: William Knak
# https://github.com/WKnak/fail2ban-netstat-synrecv-flood
# 
# This bash script prepares a log with the snapshot of netstat and all
# current SYN_RECV connection states.
#
# See documentation in GitHub

# for newer versions for fail2ban
netstat -an | grep SYN_RECV > /var/log/fail2ban_netstat_synrecv_flood.log

# for older versions of fail2ban, logs lines are suppose to have date and time
# netstat -an | grep SYN_RECV | sed -r "s/tcp6?/$(date +%Y)-$(date +%m)-$(date +%d) $(date +%H):$(date +%M):$(date +%S)/g" > /var/log/fail2ban_netstat_synrecv_flood.log
