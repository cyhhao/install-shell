yum install gcc-c++
yum install -y tcl
yum install wget
yum install epel-release yum-utils
yum install http://rpms.remirepo.net/enterprise/remi-release-7.rpm
yum-config-manager --enable remi
yum install redis
systemctl start redis.service
systemctl enable redis.service
echo "bind 127.0.0.1 ::1" >> /etc/redis.conf
systemctl restart redis