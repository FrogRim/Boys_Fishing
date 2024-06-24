from django.contrib import admin

# Register your models here.
from .models import ShoppingCart,Product

admin.site.register(Product)
admin.site.register(ShoppingCart)
