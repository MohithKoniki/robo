statuscheck() {
   if [ $? -eq 0 ]
     then
     echo status = SUCCESS
     else
     echo status = FAILURE
     exit 1
    fi
 }

 nodejs() {
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



   echo "download ${COMPONENT} application code"
    curl -s -L -o /tmp/${COMPONENT}.zip "https://github.com/roboshop-devops-project/${COMPONENT}/archive/main.zip" &>>$LOG_FILE
    statuscheck $?

    cd /home/roboshop

     echo "clean old content"
     rm -rf ${COMPONENT}  ${COMPONENT}-main &>>{LOG_FILE}
     statuscheck $?

    echo "unzipping"
    unzip /tmp/${COMPONENT}.zip &>>$LOG_FILE
     statuscheck $?

   echo "moving 1"
    mv ${COMPONENT}-main ${COMPONENT} &>>$LOG_FILE
     statuscheck $?

   echo "cd"
    cd /home/roboshop/${COMPONENT} &>>$LOG_FILE
    statuscheck $?

   echo "installing npm"
   npm install &>>$LOG_FILE
   statuscheck $?

   echo "update systemd service file"
   sed -i -e 's/REDIS_ENDPOINT/redis.robo.internal/' -e 's/MONGO_ENDPOINT/mongo.robo.internal/' /home/robo/${COMPONENT}/systemd.service
   statuscheck $?

   echo "moving files"
    mv /home/roboshop/${COMPONENT}/systemd.service /etc/systemd/system/${COMPONENT}
    .service
     statuscheck $?

    echo "reloading"
    systemctl daemon-reload &>>$LOG_FILE
    statuscheck $?

   echo "starting"
    systemctl start user &>>$LOG_FILE
    statuscheck $?

    echo "enabling"
    systemctl enable user &>>$LOG_FILE
    statuscheck $?
 }