#!/bin/bash
# file name preinst
# Install script for harden nginx.

echo "Looking for old versions of nginx ..."

if [ -f "/usr/sbin/nginx" ];then
    sudo rm -f /usr/sbin/nginx
    echo "Removed old nginx from /usr/sbin ..."
fi

if [ -d "/etc/nginx" ];then
    sudo rm -rf /etc/nginx/
    echo "Removed old nginx from /etc/nginx ..."
fi

if [ -f "/var/run/nginx.pid" ];then
    sudo rm -f /var/run/nginx.pid
    echo "Removed old nginx PID from /var/run/nginx.pid ..."
fi

if [ -f "/lib/systemd/system/nginx.service" ];then
    sudo rm -f /lib/systemd/system/nginx.service
    echo "Removed old nginx Service ..."
fi

echo " remove user nginx"
deluser nginx
delgroup nginx

# adding user and group nginx 
echo " Adding user and group nginx "
groupadd nginx
useradd nginx -r -g nginx -d /var/cache/nginx -s /sbin/nologin


# build and install nginx dependencies
cd nginx_1.20.2-1_all/tmp
tar -zxf pcre-8.45.tar.gz
cd /pcre-8.45
./configure
make
sudo make install

cd nginx_1.20.2-1_all/tmp
tar -zxf zlib-1.2.11.tar.gz
cd /tmp/zlib-1.2.11
./configure
make
sudo make install

cd nginx_1.20.2-1_all/tmp
tar -zxf openssl-1.1.1g.tar.gz
cd /tmp/openssl-1.1.1g
./Configure linux-x86_64 --prefix=/usr
make
sudo make install

cd nginx_1.20.2-1_all/tmp
tar zxf nginx-1.20.2.tar.gz
cd /tmp/nginx-1.20.2

./configure --prefix=/usr/share/nginx --sbin-path=/usr/sbin/nginx --conf-path=/etc/nginx/nginx.conf --pid-path=/var/run/nginx.pid --with-pcre=/tmp/pcre-8.45 --with-zlib=/tmp/zlib-1.2.11 --with-http_ssl_module --with-stream --user=nginx --group=nginx
make
sudo make install 

# make systemcd service for nginx
cp -r nginx_1.20.2-1_all/tmp/nginx.service /lib/systemd/system/nginx.service
systemctl deamon-reload
systemctl reload nginx.service

# copy costomized error files 
cp nginx_1.20.2-1_all/tmp/*.html /usr/share/nginx/html/

# appy security policies
find /etc/nginx -type d | xargs chmod 750
find /etc/nginx -type f | xargs chmod 640
sed -i "s/daily/weekly/" /etc/logrotate.d/nginx
sed -i "s/rotate 52/rotate 13/" /etc/logrotate.d/nginx
passwd -l nginx
chown -R root:root /etc/nginx
chown root:root /var/run/nginx.pid
chown 644 /var/run/nginx.pid
chmod 400 /etc/nginx/certs/cert.key