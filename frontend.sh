LOG_FILE=/tmp/frontend

echo "installing nginx"
 yum install nginx -y &>>$LOG_FILE
 echo status = $?

 echo "enabling nginx"
 systemctl enable nginx &>>$LOG_FILE
 echo status = $?

echo "downloading repos"
 curl -s -L -o /tmp/frontend.zip "https://github.com/roboshop-devops-project/frontend/archive/main.zip" &>>$LOG_FILE
echo status = $?

 cd /usr/share/nginx/html
 rm -rf *

 echo "unzipping"
 unzip /tmp/frontend.zip &>>$LOG_FILE
 echo status =$?

 mv frontend-main/static/* .
 mv frontend-main/localhost.conf /etc/nginx/default.d/roboshop.conf

echo "restarting"
systemctl restart nginx &>>$LOG_FILE
echo status = $?