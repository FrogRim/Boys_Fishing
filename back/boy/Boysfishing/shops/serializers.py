# shopping/serializers.py
from rest_framework import serializers
from .models import Product, ShoppingCart

class ProductSerializer(serializers.ModelSerializer):
    class Meta:
        model = Product
        fields = ['id','name', 'price', 'description', 'is_available']

class ShoppingCartSerializer(serializers.ModelSerializer):
    product = ProductSerializer(read_only=True)

    class Meta:
        model = ShoppingCart
        fields = ['user', 'product', 'quantity']
