from backend.settings.base import *


ALLOWED_HOSTS = env.list('DJANGO_ALLOWED_HOSTS', default=[])
CSRF_TRUSTED_ORIGINS = env.list('DJANGO_CSRF_TRUSTED_ORIGINS', default=[])

COMPRESS_ENABLED = True
COMPRESS_OFFLINE = True
