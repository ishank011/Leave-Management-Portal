"""leave_management URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/1.9/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  url(r'^$', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  url(r'^$', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.conf.urls import url, include
    2. Add a URL to urlpatterns:  url(r'^blog/', include('blog.urls'))
"""
from django.conf.urls import url, include
from django.contrib import admin
from django.contrib.auth.views import login
from leave.views import *

urlpatterns = [
    url(r'^login/$', login, name='login'),
    url(r'^dashboard/$', dashboard, name='dashboard'),
    url(r'^app_leave/$', app_leave, name='app_leave'),
    url(r'^past_app/$', past_app, name='past_app'),
    url(r'^del_app/(?P<l_id>\w+)$', del_app, name='del_app'),
    url(r'^days_left/$', days_left, name='days_left'),
    url(r'^leave_types/$', leave_types, name='leave_types'),
    url(r'^admin_dashboard/$', admin_dashboard, name='admin_dashboard'),
    url(r'^faculty/(?P<fac_id>\w+)$', faculty, name='faculty'),
    url(r'^review/(?P<l_id>\w+)$', review, name='review'),
    url(r'^add_faculty/$', add_faculty, name='add_faculty'),
    url(r'^update_max_days$', update_max_days, name='update_max_days'),
    url(r'^logout/$', logout, name='logout'),
]
