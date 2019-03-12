#!/bin/bash

# TODO: wait for postgres to be ready

# TODO: maybe put dependencies into requirements.txt or build a custom docker
# image with all the dependencies in place
pip3.7 install django
pip3.7 install djangorestframework
pip3.7 install psycopg2
pip3.7 install psycopg2-binary

cd /usr/src/app
# TODO: this results in such error:
# FATAL:  database "ProjectLanguage" does not exist
python manage.py makemigrations
python manage.py migrate
