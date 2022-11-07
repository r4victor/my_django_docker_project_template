from datetime import datetime, date

from django.utils import timezone


def get_now() -> datetime:
    return timezone.now()


def get_today() -> date:
    return get_now().date()
