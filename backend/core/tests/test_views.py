from django.test import TestCase
from django.http import HttpResponse


class IndexTest(TestCase):

    def get_index(self) -> HttpResponse:
        return self.client.get('')

    def test_returns_200(self):
        response = self.get_index()
        self.assertEqual(response.status_code, 200)
