#!/usr/bin/env bash

read -p "Enter your v2ray server host(s) space separated:"
servers=$REPLY

read -p "Enter your v2ray server port:"
port=$REPLY

read -p "Enter your websocket sub path:"
subpath=$REPLY

read -p "Enter your v2-ui server host:"
v2ui_server_name=$REPLY

read -p "Enter your v2-ui port:"
v2ui_port=$REPLY


cat << EOF > /etc/nginx/conf.d/v2ray.conf
server {
    listen       80;
    server_name  $servers;

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

server {
    listen       80;
    server_name  $v2ui_server_name;

    root /usr/share/nginx/html;
    index index.html;

    location / {
        proxy_redirect off;
        proxy_pass http://127.0.0.1:$v2ui_port;
        proxy_http_version 1.1;
        proxy_set_header Upgrade \$http_upgrade;
        proxy_set_header Connection "upgrade";
        proxy_set_header Host \$http_host;
    }


}
EOF

./install-certbot.sh

sudo certbot --nginx
cp /etc/nginx/conf.d/default.conf /etc/nginx/conf.d/default.conf.bak
cat << EOF > /etc/nginx/conf.d/default.conf
server {
    listen       80;
    server_name _;
    rewrite ^(.*)$  https://$host$1 permanent;

}

EOF

sudo nginx -s reload

