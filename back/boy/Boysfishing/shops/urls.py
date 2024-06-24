# shopping/urls.py
from django.urls import include, path
from rest_framework.routers import DefaultRouter
from .views import ProductViewSet, ShoppingCartViewSet

router = DefaultRouter()
router.register(r'products', ProductViewSet)
router.register(r'shopping-cart', ShoppingCartViewSet)

urlpatterns = [
    path('', include(router.urls)),
]
