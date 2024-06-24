
from django.contrib import admin
from django.urls import path

from django.contrib import admin
from django.urls import path, include

urlpatterns = [

    path('admin/', admin.site.urls),
    path('accounts/', include('accounts.urls')),
    path('shops/', include('shops.urls')),
    path('boards/', include('boards.urls')),
    path('api/', include('exApis.urls')),


]

