#!/bin/bash

SMTP_SERVER="smtp.example.com"      
SMTP_PORT="587"                     
SMTP_USER="your_email@example.com"  
SMTP_PASSWORD="your_password"      
EMAIL_TO="admin@example.com"        
DISK_TO_MONITOR="/"                 

send_alert() {
    local subject="на диске $DISK_TO_MONITOR занято $1%"
    local body="на сервере $(hostname) на диске $DISK_TO_MONITOR занято $1% места"

    echo -e "Subject: $subject\n\n$body" | \
    sendemail -f "$SMTP_USER" \
              -t "$EMAIL_TO" \
              -u "$subject" \
              -m "$body" \
              -s "$SMTP_SERVER:$SMTP_PORT" \
              -o tls=yes \
              -xu "$SMTP_USER" \
              -xp "$SMTP_PASSWORD" \
              -o message-charset=utf-8
}

USED_PERCENT=$(df -h --output=pcent "$DISK_TO_MONITOR" | tail -n 1 | tr -d '% ')

if [ "$USED_PERCENT" -ge 85 ]; then
    echo "диск $DISK_TO_MONITOR заполнен на $USED_PERCENT%, отправляю уведомление..."
    send_alert "$USED_PERCENT"
else
    echo "диск $DISK_TO_MONITOR заполнен на $USED_PERCENT%"
fi