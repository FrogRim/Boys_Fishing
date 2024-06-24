# shopping/views.py
from rest_framework import viewsets
from .models import Product, ShoppingCart
from .serializers import ProductSerializer, ShoppingCartSerializer
from rest_framework.response import Response
from rest_framework import status
from rest_framework.decorators import action
from rest_framework.exceptions import ValidationError
from rest_framework.permissions import IsAuthenticated

class ProductViewSet(viewsets.ReadOnlyModelViewSet):
    queryset = Product.objects.all()
    serializer_class = ProductSerializer

class ShoppingCartViewSet(viewsets.ModelViewSet):
    permission_classes = [IsAuthenticated]
    queryset = ShoppingCart.objects.all()
    serializer_class = ShoppingCartSerializer

    @action(detail=False, methods=['post'], url_path='add_to_cart')
    def add_to_cart(self, request, *args, **kwargs):
        try:
            product_id = request.data.get('product_id')
            if not product_id:
                raise ValidationError({"product_id": "Product ID is required."})

            product = Product.objects.get(id=product_id)
            quantity = request.data.get('quantity', 1)
            user = request.user

            cart_item, created = ShoppingCart.objects.update_or_create(
                user=user, product=product,
                defaults={'quantity': quantity}
            )

            if created:
                return Response({"message": "상품이 장바구니에 추가되었습니다."}, status=status.HTTP_201_CREATED)
            else:
                return Response({"message": "장바구니가 업데이트 되었습니다."}, status=status.HTTP_200_OK)
        except Product.DoesNotExist:
            return Response({"error": "Product not found"}, status=status.HTTP_404_NOT_FOUND)
        except Exception as e:
            print((str(e)))
            return Response({"error": str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)