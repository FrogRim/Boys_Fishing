# users/views.py
from django.contrib.auth import authenticate, login, logout
from rest_framework import status, permissions
from rest_framework.response import Response
from rest_framework.views import APIView
from rest_framework_simplejwt.tokens import RefreshToken
from rest_framework import viewsets
from .models import User
from .serializers import UserSerializer
import logging
logger = logging.getLogger(__name__)

def get_tokens_for_user(user):
    # 주어진 사용자에 대한 JWT 토큰 쌍을 생성합니다.
    refresh = RefreshToken.for_user(user)
    return {
        'refresh': str(refresh),
        'access': str(refresh.access_token),
    }

class RegisterAPIView(APIView):
    # 회원가입을 위한 API 뷰입니다. 모든 사용자가 접근할 수 있습니다.
    permission_classes = [permissions.AllowAny]

    def post(self, request):
        # 요청 데이터를 사용하여 새 사용자를 등록합니다.
        logger.info("Received data: %s", request.data)
        serializer = UserSerializer(data=request.data)
        if serializer.is_valid():
            user = serializer.save()
            tokens = get_tokens_for_user(user)
            return Response({'user': serializer.data, 'user_id': user.id,'tokens': tokens}, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

class LoginAPIView(APIView):
    # 로그인을 위한 API 뷰입니다. 모든 사용자가 접근할 수 있습니다.
    permission_classes = [permissions.AllowAny]

    def post(self, request):
        # 이메일과 비밀번호를 확인하여 사용자 인증을 시도합니다.
        email = request.data.get('email')
        password = request.data.get('password')
        print(f"Logging in with email: {email}, password: {password}")  # 로깅 추가
        user = authenticate(request, username=email, password=password)
        if user is not None:
            login(request, user)  # Django의 세션 기반 인증 시스템을 사용하여 로그인
            tokens = get_tokens_for_user(user)
            return Response({'user_id': user.id, 'tokens': tokens,'email':user.email,'name':user.name }, status=status.HTTP_200_OK)
        return Response({'error': 'Invalid Credentials'}, status=status.HTTP_401_UNAUTHORIZED)

class LogoutAPIView(APIView):
    # 로그아웃을 위한 API 뷰입니다.
    def post(self, request):
        # Django의 로그아웃 메서드를 호출하여 사용자 로그아웃 처리
        logout(request)
        return Response(status=status.HTTP_204_NO_CONTENT)

class UserViewSet(viewsets.ModelViewSet):
    queryset = User.objects.all()
    serializer_class = UserSerializer