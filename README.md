# Fail2Ban NetStat SYN_RECV Flood

Some tools, scripts and filters for Fail2Ban to generate log of SYN_RECV Flood attacks.

Combined with the another project, a Python script Fail2Ban Block IP Range (fail2ban-block-ip-range), link below, the resulting LOG with the IPs can be combined and filtered by CIDR, so future attacks can be avoided
 
https://github.com/WKnak/fail2ban-block-ip-range

## Installation


1. Clone the project to your Linux computer

```
cd /usr/local/src

git clone https://github.com/WKnak/fail2ban-netstat-synrecv-flood.git

cd fail2ban-netstat-synrecv-flood
```

2. Schedule the bash script to run periodically with crontab (each minute)

Make it executable
```
chmod +x generate_netstat_synrecv_flood_log.sh
```

Add to Crontab
```
crontab -e
```

add the line 

```
* * * * * /usr/local/src/fail2ban-netstat-synrecv-flood/generate_netstat_synrecv_flood_log.sh
```

After a minute, check if the file was created.

```
tail /var/log/fail2ban_netstat_synrecv_flood.log
```

3. Install Filter and Jail settings

```
cd /usr/local/src/fail2ban-netstat-synrecv-flood

cp filter.d/netstat_synrecv.conf /etc/fail2ban/filter.d

cp jail.d/netstat_synrecv.conf /etc/fail2ban/jail.d
```

4. Test the settings 

If the log file already contains some entries, test the settingins using this command below:

```
fail2ban-regex /var/log/fail2ban_netstat_synrecv_flood.log /etc/fail2ban/filter.d/netstat_synrecv.conf
```

4.1. ✅ If everything is OK, it will find some matches. 

Example output, go to 5.
```
Lines: 244 lines, 0 ignored, *244 matched*, 0 missed
[processed in 0.02 sec]
```

4.2. 💢 (or) If it fails and you have a old version of Fail2Ban: 
```
Lines: 244 lines, 0 ignored, 0 matched, *244 missed*
[processed in 0.02 sec]
```

💡 Then adjust the bash script `generate_netstat_synrecv_flood_log.sh compatibility` to run with the `compatibility` command line argument to include the datetime

4.3. Advanced filtering

Adjust the filter `failregex` to only match port `:443`, or other filter you want to block.

5. Reload Fail2Ban and check jail Status

```
fail2ban-client reload

fail2ban-client status netstat-synrecv
```

Example output:

```
Status for the jail: netstat-synrecv
|- Filter
|  |- Currently failed: 17
|  |- Total failed:     10188
|  `- File list:        /var/log/fail2ban_netstat_synrecv_flood.log
`- Actions
   |- Currently banned: 113
   |- Total banned:     181
   `- Banned IP list:   191.36.136.0/21 200.10.239.0/24 38.57.117.0/24 177.46.4.0/22 138.185.240.0/22 45.233.208.0/22 186.26.76.0/22 190.111.96.0/24 187.33.132.0/24 187.33.142.0/24 45.228.212.0/22 45.236.136.0/22 187.103.168.0/21 187.103.160.0/21 190.111.96.0/22 201.182.56.0/22 177.72.32.0/21 168.232.220.0/22 45.5.132.0/22 170.231.108.0/22 45.4.178.0/24 187.33.142.0/23 186.195.48.0/21 186.195.56.0/21 177.124.135.0/24 177.36.152.0/21 45.188.176.0/22 177.36.128.0/21 38.190.2.0/24 177.36.136.0/21 177.23.110.0/23 187.33.128.0/21 143.208.116.0/22 187.49.215.0/24 45.177.160.0/22 177.23.108.0/22 201.71.8.0/23 128.201.152.0/22 (...)
```

