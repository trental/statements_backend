from django.urls import path
from . import views
from rest_framework.routers import DefaultRouter
# from rest_framework_simplejwt import views as jwt_views

urlpatterns = [
    path('test', views.Test.as_view(), name='test'),
    # path('transaction/new', views.TransactionNew.as_view(), name='transaction_new'),
]