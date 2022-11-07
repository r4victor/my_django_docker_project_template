#!/bin/sh

python manage.py collectstatic --noinput && python manage.py compress

gunicorn backend.wsgi --bind=0.0.0.0
