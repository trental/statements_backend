from django.urls import path
from . import views
from rest_framework.routers import DefaultRouter

urlpatterns = [
    path('new', views.NewUser.as_view(), name='new_user'),
    path('', views.UserData.as_view(), name='user'),
]