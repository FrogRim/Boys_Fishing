# boards/serializers.py
from rest_framework import serializers,viewsets
from .models import Post, Comment, Like


class PostSerializer(serializers.ModelSerializer):
    comments_count = serializers.IntegerField(read_only=True,default=0)
    likes_count = serializers.IntegerField(read_only=True,default=0)
    class Meta:
        model = Post
        fields = ['id','author', 'title', 'content', 'created_at', 'comments_count', 'likes_count']
    def get_likes_count(self, obj):
        # 해당 포스트의 Like 모델 인스턴스 수를 반환
        return Like.objects.filter(post=obj).count()

    def get_comments_count(self, obj):
        # 해당 포스트의 Comment 모델 인스턴스 수를 반환
        return Comment.objects.filter(post=obj).count()


class CommentSerializer(serializers.ModelSerializer):
    class Meta:
        model = Comment
        fields = ['post', 'author', 'content', 'created_at']

class LikeSerializer(serializers.ModelSerializer):
    class Meta:
        model = Like
        fields = ['post', 'user']
