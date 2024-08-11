# Install on Alpine

# Download the latest version of cloudflared
wget https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64 -O /usr/bin/cloudflared

# Give executable permissions to the downloaded file
chmod +x /usr/bin/cloudflared

# Check the version of cloudflared to confirm the installation
cloudflared -v


### Create a script file in the /etc/local.d directory. For example:

```sudo vim /etc/local.d/manual_cloudflared.start```


### Populate the script with the commands you want to execute:
```
#!/bin/sh
# Your script commands here
/etc/init.d/cloudflared start
```

### Make the script executable:
```
sudo chmod +x /etc/local.d/my_script.start
```

### Add the Script to the Default Runlevel:

```
rc-update add local default
```
