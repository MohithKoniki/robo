 LOG_FILE=/tmp/catalouge

 echo "set repos"
 curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>$LOG_FILE
 echo status = $?

 echo  "install nodejs"
 yum install nodejs -y &>>$LOG_FILE
echo status = $?

echo "add user"
 useradd roboshop &>>$LOG_FILE
 echo status = $?

echo "download catalouge application code"
 curl -s -L -o /tmp/catalogue.zip "https://github.com/roboshop-devops-project/catalogue/archive/main.zip" &>>$LOG_FILE
 echo status = $?

 cd /home/roboshop

 echo "unzipping"
 unzip /tmp/catalogue.zip &>>$LOG_FILE
 echo status = $?

 mv catalogue-main catalogue &>>$LOG_FILE
 cd /home/roboshop/catalogue &>>$LOG_FILE

echo "installing npm"
npm install &>>$LOG_FILE
echo status = $?

 mv /home/roboshop/catalogue/systemd.service /etc/systemd/system/catalogue.service

 echo "reloading"
 systemctl daemon-reload &>>$LOG_FILE
echo status = $?

echo "starting"
 systemctl start catalogue &>>$LOG_FILE
 echo status = $?

 echo "enabling"
 systemctl enable catalogue &>>$LOG_FILE
echo status = $?