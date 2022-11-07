#!/bin/sh
python manage.py collectstatic --noinput && python manage.py compress

wait-for-it -t 60 postgres:5432

exec "$@"
