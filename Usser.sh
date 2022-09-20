LOG_FILE=/tmp/user

source common.sh

 echo "set repos"
 curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>$LOG_FILE
statuscheck $?

 echo  "install nodejs"
 yum install nodejs -y &>>$LOG_FILE
statuscheck $?

id roboshop &>>${LOG_FILE}
if [ $? -ne 0 ]; then
 echo "add user"
 useradd roboshop &>>$LOG_FILE
  statuscheck $?
fi



echo "download user application code"
 curl -s -L -o /tmp/user.zip "https://github.com/roboshop-devops-project/user/archive/main.zip" &>>$LOG_FILE
 statuscheck $?

 cd /home/roboshop

 echo "unzipping"
 unzip /tmp/user.zip &>>$LOG_FILE
  statuscheck $?

echo "moving 1"
 mv user-main user &>>$LOG_FILE
  statuscheck $?

echo "cd"
 cd /home/roboshop/user &>>$LOG_FILE
 statuscheck $?

echo "installing npm"
npm install &>>$LOG_FILE
statuscheck $?

echo "update systemd service file"
sed -i -e 's/REDIS_ENDPOINT/redis.robo.internal/' -e 's/MONGO_ENDPOINT/mongo.robo.internal/' /home/robo/Usser/systemd.service
statuscheck $?

echo "moving files"
 mv /home/roboshop/Usser/systemd.service /etc/systemd/system/Usser.service
  statuscheck $?

 echo "reloading"
 systemctl daemon-reload &>>$LOG_FILE
 statuscheck $?

echo "starting"
 systemctl start usser &>>$LOG_FILE
 statuscheck $?

 echo "enabling"
 systemctl enable user &>>$LOG_FILE
 statuscheck $?