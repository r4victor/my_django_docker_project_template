FROM python:3.11

RUN apt-get update && apt-get install -y nodejs npm wait-for-it
RUN npm install -g sass

WORKDIR /web
COPY backend/requirements/base.txt backend/requirements/

RUN pip install -r backend/requirements/base.txt

COPY backend backend

WORKDIR /web/backend
