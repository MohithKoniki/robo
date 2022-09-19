 LOG_FILE=/tmp/catalouge

 echo "set repos"
 curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>$LOG_FILE
 if [ $? -eq 0 ]
  then
  echo status = SUCCESS
  else
  echo status = FAILURE
  exit 1
 fi

 echo  "install nodejs"
 yum install nodejs -y &>>$LOG_FILE
 if [ $? -eq 0 ]
  then
  echo status = SUCCESS
  else
  echo status = FAILURE
  exit 1
 fi

id roboshop &>>$[LOG_FILE]
if [ $? -ne 0 ]; then
 echo "add user"
 useradd roboshop &>>$LOG_FILE
  if [ $? -eq 0 ]; then
   echo status = SUCCESS
   else
   echo status = FAILURE
   exit 1
  fi
fi

echo "download catalouge application code"
 curl -s -L -o /tmp/catalogue.zip "https://github.com/roboshop-devops-project/catalogue/archive/main.zip" &>>$LOG_FILE
  if [ $? -eq 0 ]
   then
   echo status = SUCCESS
   else
   echo status = FAILURE
   exit 1
  fi

 cd /home/roboshop

 echo "unzipping"
 unzip /tmp/catalogue.zip &>>$LOG_FILE
  if [ $? -eq 0 ]
   then
   echo status = SUCCESS
   else
   echo status = FAILURE
   exit 1
  fi

echo "moving 1"
 mv catalogue-main catalogue &>>$LOG_FILE
  if [ $? -eq 0 ]
   then
   echo status = SUCCESS
   else
   echo status = FAILURE
   exit 1
  fi

echo "cd"
 cd /home/roboshop/catalogue &>>$LOG_FILE
  if [ $? -eq 0 ]
   then
   echo status = SUCCESS
   else
   echo status = FAILURE
   exit 1
  fi

echo "installing npm"
npm install &>>$LOG_FILE
 if [ $? -eq 0 ]
  then
  echo status = SUCCESS
  else
  echo status = FAILURE
  exit 1
 fi

echo "moving files"
 mv /home/roboshop/catalogue/systemd.service /etc/systemd/system/catalogue.service
  if [ $? -eq 0 ]
   then
   echo status = SUCCESS
   else
   echo status = FAILURE
   exit 1
  fi

 echo "reloading"
 systemctl daemon-reload &>>$LOG_FILE
 if [ $? -eq 0 ]
  then
  echo status = SUCCESS
  else
  echo status = FAILURE
  exit 1
 fi

echo "starting"
 systemctl start catalogue &>>$LOG_FILE
  if [ $? -eq 0 ]
   then
   echo status = SUCCESS
   else
   echo status = FAILURE
   exit 1
  fi

 echo "enabling"
 systemctl enable catalogue &>>$LOG_FILE
 if [ $? -eq 0 ]
  then
  echo status = SUCCESS
  else
  echo status = FAILURE
  exit 1
 fi