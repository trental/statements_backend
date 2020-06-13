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

file = open(os.path.join(os.path.dirname(os.path.abspath(__file__)), 'sql', 'subtotals.sql'), mode='r')
subtotalSQL = file.read()

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
    def post(self, request):
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

        
        cursor = connection.cursor()
        
        # results will dump into temp table "output"
        cursor.execute('create temp table output as ' + statementSQL.replace('**user_id**', str(request.user.id)).replace('**begin_date**', begin_date).replace('**end_date**', end_date).replace('**transaction_list**', transaction_list))

        cursor.execute('create temp table output_subtotal as ' + subtotalSQL)

        cursor.execute('select statement_type, line_item_order, line_item, line_format, round(amount,0)::integer as amount from output_subtotal order by statement_type, line_item_order;') 

        data = cursor.fetchall()

        for t in list(data):
            print(t)
            if t[0] not in result:
                result[t[0]] = []
            result[t[0]].append({'line_item_order':t[1], 'line_item':t[2], 'line_format':t[3], 'amount':t[4]})

        cursor.close()
        connection.close()

        return Response(result)

class TransactionTypes(APIView):
    
    def get(self, request):
        transactions = Transaction.objects.raw("select * from statements_transaction order by transaction_type, case when transaction_property = 'accounting_date' then 1 when transaction_property = 'transaction_date' then 2 when transaction_property = 'description' then 3 else 5 end, transaction_property")
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
            cursor.execute(transactionSQL.format(transaction_type, transaction_date, accounting_date, description.replace("'",""), str(user_id)))
            newTransaction = cursor.fetchone()[0]
            for k in body[transaction_type]:
                if k not in ['transactionDate', 'accountingDate', 'description']:
                    transaction_property = k
                    transaction_value = body[transaction_type][k]
                    detailSQL = "insert into statements_usertransactiondetail (user_transaction_id, transaction_property, transaction_value) values ({}, '{}', {});"
                    cursor.execute(detailSQL.format(newTransaction, transaction_property, transaction_value))

            body[transaction_type]['id'] = newTransaction

        cursor.close()
        connection.close()

        return Response(body)

class TransactionData(APIView):

    def get(self, request, pk):
        result = {}
        transaction = UserTransaction.objects.get(id=pk)

        if transaction and transaction.user_id == request.user.id:
            # print(transaction.transaction_date)
            result[transaction.transaction_type] = {}
            result[transaction.transaction_type]['id'] = transaction.id
            details = UserTransactionDetail.objects.all().filter(user_transaction_id=transaction.id)
            print(details)
            for d in list(details):
                result[transaction.transaction_type][d.transaction_property] = d.transaction_value
            result[transaction.transaction_type]['transaction_date'] = str(transaction.transaction_date)
            result[transaction.transaction_type]['accounting_date'] = str(transaction.accounting_date)
            result[transaction.transaction_type]['description'] = transaction.description
            
        return Response(result)

    def put(self, request, pk):
        result = {}
        transaction = UserTransaction.objects.get(id=pk)
        body_unicode = request.body.decode('utf-8')
        body = json.loads(body_unicode)

        for t in body:
            if transaction and transaction.user_id == request.user.id:

                transaction.transaction_date = body[t]['transaction_date']
                transaction.accounting_date = body[t]['accounting_date']
                transaction.description = str(body[t]['description']).replace("'","")

                transaction.save()

                UserTransactionDetail.objects.filter(user_transaction_id=pk).delete()

                cursor = connection.cursor()

                for k in body[t]:
                    if k not in ['transaction_date', 'accounting_date', 'description', 'id']:
                        transaction_property = k
                        transaction_value = body[t][k]
                        detailSQL = "insert into statements_usertransactiondetail (user_transaction_id, transaction_property, transaction_value) values ({}, '{}', {});"
                        cursor.execute(detailSQL.format(pk, transaction_property, transaction_value))

                cursor.close()
                connection.close()

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
        transactions = UserTransaction.objects.all().filter(user_id=request.user.id).order_by('accounting_date')
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
