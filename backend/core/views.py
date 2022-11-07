from django.shortcuts import render
from django.http import HttpRequest, HttpResponse
from django.views.decorators.http import require_GET

from core.utils.logging_utils import get_logger


logger = get_logger(__name__)


@require_GET
def index(request: HttpRequest) -> HttpResponse:
    logger.info('We got a hit!')
    context = {
        'message': 'Hello!'
    }
    return render(request, 'core/index.html', context)
