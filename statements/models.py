from django.db import models
from django.contrib.auth.models import User

# Create your models here.
class UserTransaction(models.Model):
    transaction_type = models.CharField(max_length=255)
    transaction_date = models.DateField()
    accounting_date = models.DateField()
    description = models.TextField()
    user = models.ForeignKey(User, on_delete=models.CASCADE, related_name='user')

class Transaction(models.Model):
    transaction_type = models.CharField(max_length=255)
    transaction_property = models.CharField(max_length=255)
    transaction_property_datatype = models.CharField(max_length=255, default='number')    

class UserTransactionDetail(models.Model):
    user_transaction = models.ForeignKey(UserTransaction, on_delete=models.CASCADE, related_name='user_transaction')
    transaction_property = models.CharField(max_length=255)
    transaction_value = models.IntegerField()

class Statement(models.Model):
    statement_type = models.CharField(max_length=255)

class StatementDetail(models.Model):
    statement = models.ForeignKey(Statement, on_delete=models.CASCADE, related_name='statement')
    line_item = models.CharField(max_length=255)
    line_item_order = models.IntegerField()

class Transaction_StatementDetail_Bridge(models.Model):
    transaction_property = models.ForeignKey(Transaction, on_delete=models.CASCADE, related_name='transaction_property_id')
    line_item = models.ForeignKey(StatementDetail, on_delete=models.CASCADE, related_name='line_item_id')
    sign = models.IntegerField()
