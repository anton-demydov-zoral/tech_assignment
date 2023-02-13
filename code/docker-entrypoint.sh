#!/bin/sh
# Check if our environment variable has been passed.

if [ -z "${APP_PORT}" ]
then
  echo "APP_PORT has not been set. Fix the Terraform code"
  exit 1
else

sed -i "s|APP_PORT|'$APP_PORT'|g" /usr/src/app/app.py

python3 /usr/src/app/app.py

