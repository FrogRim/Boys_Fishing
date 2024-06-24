# apis/models.py
from django.db import models

# 외부 API 정보 모델
class ExternalAPI(models.Model):
    name = models.CharField(max_length=255)
    endpoint = models.URLField()
    last_called = models.DateTimeField(auto_now=True)

    def __str__(self):
        return self.name
