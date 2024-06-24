from django import forms
from .models import User

# User 폼 정의
class UserForm(forms.ModelForm):
    class Meta:
        model = User
        fields = ['email', 'password']


