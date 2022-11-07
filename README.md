# my_django_docker_project_template

This repo is a blueprint for building simple Django+Postgres+Gunicorn+nginx+Docker web projects to be deployed on a single VPS. 


## Overview

The `backend` directory is the output of `django-admin startproject` with some additions:

* Initialized `core` app.
* Basic dependencies such as `psycopg2` and `gunicorn`.
* Settings splitted for local and production environments and controlled by environment variables.
* Initial HTML templates and SCSS pipeline. JS/SCSS files are processed (transpiled, bundled) by `django_compressor` and served with `whitenoise`.
* Common utilities.

There is also a bunch of files for local development and deployment with Docker. 

All local development is done with `docker compose` so it's easy to set up and doesn't require to install anything locally. The combination `-f docker-compose-base.yml -f docker-compose-dev.yml` defines a `postgres` service and a `web` service that runs Django dev server with the source code mounted as a volume.

The combination `-f docker-compose-base.yml -f docker-compose-prod.yml` defines a `postgres` service, an `nginx` service running [nginx-le](https://github.com/nginx-le/nginx-le), and a `web` service that runs Gunicorn.


## Usage

### Creating a new project

1. Clone this repo:

    ```
    git clone https://github.com/r4victor/my_django_docker_project_template new_project && cd new_project
    ```

2. Init a new git folder:

    ```
    rm -r .git && git init
    ```

3. Create an `.env` file from the template:

    ```
    mv backend/.env-template backend/.env 
    ```

4. Rename `my_django_docker_project_template` to your project name in `docker-compose-base.yml`.

That's it! You have a new project set up!


### Local development

Nothing is installed locally. All local development is done with `docker compose`. To start a Django dev server, run:

```
docker compose -f docker-compose-base.yml -f docker-compose-dev.yml up
```

Other Django commands can be run in the same way:

```
docker compose -f docker-compose-base.yml -f docker-compose-dev.yml run --rm web ./manage.py migrate
```

If you need to run a production setup with nginx and Gunicorn locally, then run

```
docker compose -f docker-compose-base.yml -f docker-compose-prod.yml up --build
```

Before that, ensure that your set `DJANGO_SETTINGS_MODULE=backend.settings.prod` in `.env` and generate a local https cert by running `./scripts/generate_local_cert.sh`.


### Deployment

To deploy, you manually ssh into your server, pull the project and run `docker compose` just like locally:

```
docker compose -f docker-compose-base.yml -f docker-compose-prod.yml up --build
```

The only difference is that you need to change env variables to match your domain and set `LETSENCRYPT=true` to let nginx issue a certificate for your.


## TODO

* Static files are collected when the image starts. We can do it on image build and remove `sass` dependency from the final image. This requires some trickery to run `manage.py` in Dockerfile.
* Set up CI/CD pipeline (e.g. via GitHub Actions).
* Zero downtime deployments. One option would be to make nginx buffer requests while we run migrations and restart the app.
