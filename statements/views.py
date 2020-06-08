from django.shortcuts import render
from rest_framework.views import APIView
from rest_framework.response import Response
from django.contrib.auth.models import User
from rest_framework.permissions import IsAuthenticated
import json
from django.db import connection
from .models import Transaction
from rest_framework.permissions import AllowAny

class Test(APIView):
    permission_classes = (AllowAny,)
    
    def get(self, request):
        print(request.user.id)
        return Response({'hi':'bye'})

class TransactionTypes(APIView):
    
    def get(self, request):
        transactions = Transaction.objects.raw('select * from statements_transaction')
        result = {}
        print(User.objects.all())
        for t in list(transactions):
            if t.transaction_type not in result:
                result[t.transaction_type] = {}
            result[t.transaction_type][t.transaction_property] = t.transaction_property_datatype
        return Response(result)

class TransactionNew(APIView):
    
    def post(self, request):
        print(request.user.id)
        body_unicode = request.body.decode('utf-8')
        body = json.loads(body_unicode)
        print(body)
        user_id = request.user.id
        for t in body:
            transaction_type = t
            transaction_date = body[transaction_type]['transactionDate']
            accounting_date = body[transaction_type]['accountingDate']
            description = body[transaction_type]['description']
            transactionSQL = "insert into statements_usertransaction (transaction_type, transaction_date, accounting_date, description, user_id) values ('{}','{}','{}','{}',{}) returning id;"
            cursor = connection.cursor()
            cursor.execute(transactionSQL.format(transaction_type, transaction_date, accounting_date, description, str(user_id)))
            newTransaction = cursor.fetchone()[0]
            for k in body[transaction_type]:
                if k not in ['transactionDate', 'accountingDate', 'description']:
                    transaction_property = k
                    transaction_value = body[transaction_type][k]
                    detailSQL = "insert into statements_usertransactiondetail (user_transaction_id, transaction_property, transaction_value) values ({}, '{}', {});"
                    cursor.execute(detailSQL.format(newTransaction, transaction_property, transaction_value))


            print(newTransaction)
        return Response({'hi':'bye'})