sudo yum -y install yum-utils
sudo yum-config-manager --enable rhui-REGION-rhel-server-extras rhui-REGION-rhel-server-optional
sudo yum update --enablerepo=epel-testing
sudo pip install --upgrade pip
sudo pip install --upgrade setuptools
sudo pip uninstall psutil
sudo yum install gcc python-devel python-pip
sudo pip install psutil
sudo pip install certbot
sudo pip install certbot-nginx

# sudo certbot --nginx

echo "0 0,12 * * * root python -c 'import random; import time; time.sleep(random.random() * 3600)' && certbot renew" | sudo tee -a /etc/crontab > /dev/null
