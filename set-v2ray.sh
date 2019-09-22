#!/usr/bin/env bash

read -p "Enter your ssl_certificate path:"
ssl_certificate_path=$REPLY

read -p "Enter your ssl_certificate key path:"
ssl_certificate_key_path=$REPLY

read -p "Enter your v2ray port:"
port=$REPLY

read -p "Enter your server name(s) space separated:"
servers=$REPLY

read -p "Enter your websocket sub path:"
subpath=$REPLY


cat << EOF > /etc/nginx/conf.d/v2ray.conf
server {
    listen  443 ssl http2 default_server;
    ssl_certificate       $ssl_certificate_path; #fullchain
    ssl_certificate_key   $ssl_certificate_key_path; #key
    ssl_protocols         TLSv1.2;
    ssl_ciphers           HIGH:!aNULL:!MD5;
    server_name           $servers;
    add_header Strict-Transport-Security "max-age=63072000; includeSubdomains; ";

    root /usr/share/nginx/html;
    index index.html;

    location $subpath {
        proxy_redirect off;
        proxy_pass http://127.0.0.1:$port;
        proxy_http_version 1.1;
        proxy_set_header Upgrade \$http_upgrade;
        proxy_set_header Connection "upgrade";
        proxy_set_header Host \$http_host;
    }


}

EOF

./install-certbot.sh

sudo certbot --nginx

cat << EOF > /etc/nginx/conf.d/default.conf
server {
    listen       80;
    server_name _;
    rewrite ^(.*)$  https://$host$1 permanent;

}

EOF

sudo nginx -s reload
