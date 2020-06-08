from django.shortcuts import render
from rest_framework.views import APIView
from rest_framework.response import Response
from django.contrib.auth.models import User
from rest_framework.permissions import IsAuthenticated
import json
from django.db import connection
from rest_framework.permissions import AllowAny

class NewUser(APIView):
    
    permission_classes = (AllowAny,)

    def post(self, request):

        body_unicode = request.body.decode('utf-8')
        body = json.loads(body_unicode)

        username = body.get('username', None)
        usermail = body.get('email', None)
        userfirst = body.get('firstname', None)
        userlast = body.get('lastname', None)
        userpass = body.get('password', None)

        result = {'result':'not all data provided'}

        if username and usermail and userfirst and userlast and userpass:

            user,created = User.objects.get_or_create(username=username)
            if created:
                user.set_password(userpass)
                user.first_name = userfirst
                user.last_name = userlast
                user.email = usermail
                user.save()
                result = {'result':'user created'}
            else:
                result = {'result':'user already exists'}

        return Response(result)    

class UserData(APIView):
    
    def get(self, request):
        user = User.objects.raw('select id, last_login, username, first_name, last_name, email, date_joined from auth_user where id = {}'.format(request.user.id))
        # print(request.user.id)
        result = {}
        for t in list(user):
            result['username'] = t.username
            result['firstname'] = t.first_name
            result['lastname'] = t.last_name
            result['email'] = t.email
            result['lastLogin'] = t.last_login
            result['dateJoined'] = t.date_joined
        return Response(result)  

    def delete(self, request):

        User.objects.filter(
            id=request.user.id,
        ).delete()
        return Response({'message':'user deleted'})

    def put(self, request):

        user = User.objects.get(id=request.user.id)

        body_unicode = request.body.decode('utf-8')
        body = json.loads(body_unicode)

        username = body.get('username', None)
        usermail = body.get('email', None)
        userfirst = body.get('firstname', None)
        userlast = body.get('lastname', None)
        userpass = body.get('password', None)

        result = {'result':'not all data provided'}

        if username and usermail and userfirst and userlast and userpass:

            user = User.objects.get(id=request.user.id)
            user.set_password(userpass)
            user.first_name = userfirst
            user.last_name = userlast
            user.email = usermail
            user.save()
            result = {'result':'user updated'}

        return Response(result)    
