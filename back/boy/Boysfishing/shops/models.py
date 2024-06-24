# shopping/models.py
from django.db import models


# 상품 정보 모델
class Product(models.Model):

    name = models.CharField(max_length=255)
    price = models.IntegerField()
    description = models.TextField(blank=True, null=True)
    is_available = models.BooleanField(default=True)

    def __str__(self):
        return f'{self.id} - {self.name}'

# 장바구니 모델
class ShoppingCart(models.Model):
    user = models.ForeignKey('accounts.User', related_name='shopping_carts', on_delete=models.CASCADE)
    product = models.ForeignKey(Product, on_delete=models.CASCADE)
    quantity = models.IntegerField(default=1)

    def __str__(self):
        return f'{self.user.id} - {self.product.name} x {self.quantity}'
