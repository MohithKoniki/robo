LOG_FILE=/tmp/redis

source common.sh


echo "installing rpm"
dnf install https://rpms.remirepo.net/enterprise/remi-release-8.rpm -y &>>{LOG_FILE}
statuscheck $?

echo "enabling redis"
dnf module enable redis:remi-6.2 -y &>>{LOG_FILE}
statuscheck $?

echo "installing redis"
yum install redis -y &>>{LOG_FILE}
statuscheck $?

echo "update redis listen address"
sed -i -e 's127.0.0.1/0.0.0.0/'  /etc/redis.conf  /etc/redis/redis.conf
statuscheck $?

echo "enabling redis"
systemctl enable redis &>>{LOG_FILE}
statuscheck $?

echo "restart"
systemctl start redis &>>{LOG_FILE}
statuscheck $?