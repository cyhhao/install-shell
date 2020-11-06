yum -y groupinstall "Development tools"
yum -y install zlib-devel bzip2-devel openssl-devel ncurses-devel sqlite-devel readline-devel tk-devel gdbm-devel db4-devel libpcap-devel xz-devel libffi-devel
yum install wget git
wget https://www.python.org/ftp/python/3.8.6/Python-3.8.6.tgz
tar zxvf  Python-3.8.6.tgz
cd Python-3.8.6
./configure --prefix=/usr/local/bin/python3
make
make install
ln -s /usr/local/bin/python3/bin/python3 /usr/bin/python3
ln -s /usr/local/bin/python3/bin/pip3 /usr/bin/pip3
pip3 install --upgrade pip
pip3 install requests
