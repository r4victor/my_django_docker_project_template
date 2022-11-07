#!/bin/sh
wait-for-it -t 60 postgres:5432

exec "$@"
