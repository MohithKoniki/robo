statuscheck() {
   if [ $? -eq 0 ]
     then
     echo status = SUCCESS
     else
     echo status = FAILURE
     exit 1
    fi
 }