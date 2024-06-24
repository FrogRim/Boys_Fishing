# #boards/views.py
from rest_framework import viewsets,status
from rest_framework.decorators import action
from rest_framework.response import Response
from .models import Post, Comment, Like
from .serializers import PostSerializer, CommentSerializer, LikeSerializer
from django.shortcuts import get_object_or_404
from rest_framework.permissions import IsAuthenticated

class PostViewSet(viewsets.ModelViewSet):
    queryset = Post.objects.all()
    serializer_class = PostSerializer


class CommentViewSet(viewsets.ModelViewSet):
    permission_classes = [IsAuthenticated]
    queryset = Comment.objects.all()
    serializer_class = CommentSerializer

class LikeViewSet(viewsets.ModelViewSet):
    permission_classes = [IsAuthenticated]
    queryset = Like.objects.all()
    serializer_class = LikeSerializer

    @action(detail=True, methods=['post'], url_path='toggle')
    def toggle(self, request, pk=None):
        post = get_object_or_404(Post, pk=pk)
        user = request.user  # Django의 request.user를 사용하여 현재 인증된 사용자를 가져옵니다.

        like_qs = Like.objects.filter(post=post, user=user)
        likes_count = Like.objects.filter(post=post).count()
        if likes_count > 0:
            like_qs.delete()
            likes_count = False
            return Response({'status': 'like removed', 'likes_count': likes_count}, status=status.HTTP_204_NO_CONTENT)
        else:
            Like.objects.create(post=post, user=user)
            likes_count = True
            return Response({'status': 'like added', 'likes_count': likes_count}, status=status.HTTP_201_CREATED)
