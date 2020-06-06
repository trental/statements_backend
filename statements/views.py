from django.shortcuts import render
from rest_framework.views import APIView
from rest_framework.response import Response
from django.contrib.auth.models import User
import json
from django.db import connection

class Test(APIView):
    
    def get(self, request):
        print(request.user.id)
        return Response({'hi':'bye'})