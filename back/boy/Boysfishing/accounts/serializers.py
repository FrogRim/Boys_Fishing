# users/serializers.py
from rest_framework import serializers
from .models import User

class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = ['id', 'email', 'password', 'name', 'season_pass_progress']
        extra_kwargs = {
            'password': {'write_only': True}
        }

    def create(self, validated_data):
        # 비밀번호가 포함된 데이터를 안전하게 처리하도록 사용자 생성 메서드를 오버라이드
        password = validated_data.pop('password', None)
        instance = self.Meta.model(**validated_data)
        if password is not None:
            instance.set_password(password)
        instance.save()
        return instance

    def update(self, instance, validated_data):
        # 비밀번호 변경을 위한 로직 포함
        for attr, value in validated_data.items():
            if attr == 'password':
                instance.set_password(value)
            else:
                setattr(instance, attr, value)
        instance.save()
        return instance
