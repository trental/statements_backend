from django.urls import path
from . import views
from rest_framework.routers import DefaultRouter

urlpatterns = [
    path('test', views.Test.as_view(), name='test'),
    # path('user/new', views.UserNew.as_view(), name='user_new'),
    path('transaction/types', views.TransactionTypes.as_view(), name='transaction_types'),
    path('transaction/new', views.TransactionNew.as_view(), name='transaction_new'),
    path('transaction/<int:pk>', views.TransactionData.as_view(), name='transaction_data'),
    path('transaction', views.TransactionList.as_view(), name='transaction_list'),
    path('statement', views.StatementList.as_view(), name='statement_list'),
]