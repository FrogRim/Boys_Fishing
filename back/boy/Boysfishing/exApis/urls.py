# apis/urls.py
from django.urls import include, path
from rest_framework.routers import DefaultRouter
from .views import ExternalAPIViewSet

router = DefaultRouter()
router.register(r'external-apis', ExternalAPIViewSet)

urlpatterns = [
    path('', include(router.urls)),
]
