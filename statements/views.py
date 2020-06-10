from django.shortcuts import render
from rest_framework.views import APIView
from rest_framework.response import Response
from django.contrib.auth.models import User
from rest_framework.permissions import IsAuthenticated
import json
from django.db import connection
from .models import Transaction, UserTransaction, UserTransactionDetail
from rest_framework.permissions import AllowAny
import os

file = open(os.path.join(os.path.dirname(os.path.abspath(__file__)), 'sql', 'statements.sql'), mode='r')
statementSQL = file.read()
file.close()

def snake_to_camel(word):
        import re
        return ''.join(x.capitalize() or '_' for x in word.split('_'))

class Test(APIView):
    permission_classes = (AllowAny,)
    
    def get(self, request):
        print(request.user.id)
        return Response({'hi':'bye'})

class StatementList(APIView):
    def get(self, request):
        result = {}
        body_unicode = request.body.decode('utf-8')
        body = json.loads(body_unicode)
        begin_date = '1900-01-01'
        end_date = '3000-01-01'
        transaction_list = ''
        if 'begin_date' in body:
            begin_date = body['begin_date']
        if 'end_date' in body:
            end_date = body['end_date']
        if 'transaction_list' in body:
            transaction_list = 'and ut.id in (' + str(body['transaction_list'])[1:-1] + ')'
        print(statementSQL.replace('**user_id**', str(request.user.id)).replace('**begin_date**', begin_date).replace('**end_date**', end_date).replace('**transaction_list**', transaction_list))
        return Response(result)

class TransactionTypes(APIView):
    
    def get(self, request):
        transactions = Transaction.objects.raw('select * from statements_transaction')
        result = {}
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
        # print(body)
        user_id = request.user.id
        for t in body:
            transaction_type = t
            transaction_date = body[transaction_type]['transaction_date']
            accounting_date = body[transaction_type]['accounting_date']
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

            body[transaction_type]['id'] = newTransaction
        return Response(body)

class TransactionData(APIView):

    def get(self, request, pk):
        result = {}
        transaction = UserTransaction.objects.get(id=pk)

        if transaction and transaction.user_id == request.user.id:
            result[transaction.transaction_type] = {}
            result[transaction.transaction_type]['id'] = transaction.id
            result[transaction.transaction_type]['transaction_date'] = transaction.transaction_date
            result[transaction.transaction_type]['accounting_date'] = transaction.accounting_date
            result[transaction.transaction_type]['description'] = transaction.description
            details = UserTransactionDetail.objects.all().filter(user_transaction_id=transaction.id)
            print(details)
            for d in list(details):
                result[transaction.transaction_type][d.transaction_property] = d.transaction_value
        return Response(result)

    def put(self, request, pk):
        result = {}
        transaction = UserTransaction.objects.get(id=pk)
        body_unicode = request.body.decode('utf-8')
        body = json.loads(body_unicode)

        for t in body:
            if transaction and transaction.user_id == request.user.id:

                transaction.transaction_date = body[t]['transactionDate']
                transaction.accounting_date = body[t]['accountingDate']
                transaction.description = body[t]['description']

                transaction.save()

                UserTransactionDetail.objects.filter(user_transaction_id=pk).delete()

                cursor = connection.cursor()

                for k in body[t]:
                    if k not in ['transactionDate', 'accountingDate', 'description', 'id']:
                        transaction_property = k
                        transaction_value = body[t][k]
                        detailSQL = "insert into statements_usertransactiondetail (user_transaction_id, transaction_property, transaction_value) values ({}, '{}', {});"
                        cursor.execute(detailSQL.format(pk, transaction_property, transaction_value))

        return Response(result)    

    def delete(self, request, pk):

        t = UserTransaction.objects.get(id=pk)
        if t.user_id == request.user.id:
            UserTransactionDetail.objects.filter(user_transaction_id=pk).delete()
            t.delete()

        return Response({'deleted'})

class TransactionList(APIView):

    def get(self, request):
        result = []
        transactions = UserTransaction.objects.all().filter(user_id=request.user.id)
        print(transactions)
        for t in list(transactions):
            el = {}
            el['id'] = t.id
            el['transaction_type'] = t.transaction_type
            el['transaction_date'] = t.transaction_date
            el['accounting_date'] = t.accounting_date
            el['description'] = t.description
            result.append(el)
        return Response(result)
