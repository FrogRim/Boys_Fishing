# api_integration/views.py
from rest_framework import viewsets
from .models import ExternalAPI
from .serializers import ExternalAPISerializer

class ExternalAPIViewSet(viewsets.ModelViewSet):
    queryset = ExternalAPI.objects.all()
    serializer_class = ExternalAPISerializer
