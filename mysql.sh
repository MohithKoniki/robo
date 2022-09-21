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

Default_password=$(grep 'A temporary password' /var/log/mysqld.log | awk '{print $NF}')
echo "set password for 'root'@'hostname' = password
('${roboshop_mysql_password}')
FLUSH PRIVILEGES;" >/tmp/root-pass.sql

echo "show databases;" |mysql -uroot -p${ROBOSHOP MYSQL PASSWORD} &>>{LOG_FILE}
if [ $? ne 0] ; then
 echo "change the default password"
 mysql --connect -expired-password -uroot -p"${Default_password}" </tmp/root-pass.sql  &>>{LOG_FILE}
 statuscheck $?
fi

