LOG_FILE=/tmp/mongodb

echo "downloading repos"
curl -s -o /etc/yum.repos.d/mongodb.repo https://raw.githubusercontent.com/roboshop-devops-project/mongodb/main/mongo.repo &>>$LOG_FILE
echo status = $?

echo "installing nginx"
yum install -y mongodb-org &>>$LOG_FILE
echo status =$?

echo "enabling mongodb"
systemctl enable mongod &>>$LOG_FILE
echo status = $?

echo "restarting mongodb"
systemctl start mongod &>>$LOG_FILE
echo status = $?