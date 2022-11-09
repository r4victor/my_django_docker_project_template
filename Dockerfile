FROM python:3.11 as build

RUN cd /opt && \
    wget https://github.com/sass/dart-sass/releases/download/1.56.0/dart-sass-1.56.0-linux-x64.tar.gz && \
    tar xzf dart-sass-1.56.0-linux-x64.tar.gz
ENV PATH=/opt/dart-sass:$PATH

WORKDIR /web
RUN python -m venv venv
ENV PATH=/web/venv/bin:$PATH

COPY backend/requirements/base.txt backend/requirements/
RUN pip install -r backend/requirements/base.txt

COPY backend backend

WORKDIR /web/backend
ENV DJANGO_SETTINGS_MODULE=backend.settings.prod
RUN python manage.py collectstatic --noinput && python manage.py compress


FROM python:3.11-slim

RUN apt-get update && apt-get install -y libpq-dev wait-for-it

COPY --from=build /web/venv /web/venv
COPY --from=build /web/backend /web/backend

ENV PATH=/web/venv/bin:$PATH
WORKDIR /web/backend
