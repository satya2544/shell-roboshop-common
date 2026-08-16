#!/bin/bash

source ./common.sh
check_root

cp $SCRIPT_DIR/rabbitmq.repo /etc/yum.repos.d/rabbitmq.repo
dnf install rabbitmq-server -y &>>$LOG_FILE 
VALIDATE $? "Installing rabbitmq Server"
systemctl enable rabbitmq-server &>>$LOG_FILE 
VALIDATE $? "Enabling rabbitmq Server"
systemctl start rabbitmq-server &>>$LOG_FILE
VALIDATE $? "Starting rabbitmq Server"
rabbitmqctl add_user roboshop roboshop123
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"
VALIDATE $? "Setting up permissionsr"

print_total_time