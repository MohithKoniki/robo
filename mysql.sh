LOG_FILE=&>>/tmp/mysql

source common.sh


echo "installing repo files"
 curl -s -L -o /etc/yum.repos.d/mysql.repo https://raw.githubusercontent.com/roboshop-devops-project/mysql/main/mysql.repo &>>{LOG_FILE}
 statuscheck $?

 echo "disabling mysql files"
 dnf module disable mysql  &>>{LOG_FILE}
statuscheck $?

echo "installing mysql files"
 yum install mysql-community-server -y  &>>{LOG_FILE}
statuscheck $?

echo "start mysql"
 systemctl enable mysqld  &>>{LOG_FILE}
 systemctl start mysqld  &>>{LOG_FILE}
 statuscheck $?

 grep temp /var/log/mysqld.log

