# api_integration/serializers.py
from rest_framework import serializers
from .models import ExternalAPI

class ExternalAPISerializer(serializers.ModelSerializer):
    class Meta:
        model = ExternalAPI
        fields = ['name', 'endpoint', 'last_called']
