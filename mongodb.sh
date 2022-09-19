LOG_FILE=/tmp/mongodb

statuscheck() {
   if [ $? -eq 0 ]
     then
     echo status = SUCCESS
     else
     echo status = FAILURE
     exit 1
    fi
 }

echo "downloading repos"
curl -s -o /etc/yum.repos.d/mongodb.repo https://raw.githubusercontent.com/roboshop-devops-project/mongodb/main/mongo.repo &>>$LOG_FILE
statuscheck $?

echo "installing nginx"
yum install -y mongodb-org &>>$LOG_FILE
statuscheck $?

echo "changing ip address"
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf
statuscheck $?

echo "enabling mongodb"
systemctl enable mongod &>>$LOG_FILE
statuscheck $?

echo "restarting mongodb"
systemctl start mongod &>>$LOG_FILE
statuscheck $?

echo "downloading schema"
 curl -s -L -o /tmp/mongodb.zip "https://github.com/roboshop-devops-project/mongodb/archive/main.zip" &>>$LOG_FILE
statuscheck $?


cd /tmp

echo "unzipping"
unzip mongodb.zip &>>$LOG_FILE
statuscheck $?


cd mongodb-main

 echo "loading service schema"
 mongo < catalogue.js &>>$LOG_FILE
 mongo < users.js &>>$LOG_FILE
statuscheck $?