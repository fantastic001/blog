---
layout: post
title:  "Deploying your web application based on REST API"
date:   2016-05-23 00:02:00 +0100
categories: web
---

Well, you have developed your first version of your super-mega-giga web app and you want to deploy it. Your application consists of
two parts: API (backend) and your javascript code (frontend). In this article, I am going to explain how to deploy your API
written in Django and your frontend written in AngularJS with a little bit of help of NodeJS and npm. 

API deployment - Docker configuration
----------------------------------------

It is good practice to use docker to isolate your environment for every app you are planning to use. We will set up 2 docker containers: one for Django app and one for database we use in our backend. 

When you have situation like this: to have more containers bound in some way, it is always recommanded to use docker-compose to 
easily manage your containers. 

First, we will make Dockerfile for our container serving our Django API

Here is an example of Dockerfile to use:

	FROM python:3.4
	ENV PYTHONUNBUFFERED 1
	# ssh-keygen is needed because some packages from requirements.txt are not available on pypy and are git cloned instead
	RUN ssh-keygen -q -t rsa -N '' -f id_rsa
	RUN apt-get update && apt-get install netcat -y
	RUN mkdir /code
	WORKDIR /code
	ADD requirements.txt /code/
	ADD requirements-dev.txt /code/
	RUN pip install -r requirements.txt && pip install -r requirements-dev.txt && pip install uwsgi
	ADD . /code/
	RUN groupadd -r youruser && useradd -r -g youruser youruser
	USER youruser

This image will download and install needed packages for deployment and install all libraries listed in requirements.txt as well as in
requirements-dev.txt. Just list your dependencies by their name in Python package index. 

Now, you have to configure your docker-compose.yml:

	db:
	    image: postgres
	web:
	    build: .
	    command: sh bin/production.sh 9005
	    volumes:
	        - .:/code
	    ports:
	        - "9005:9005"
	    links:
	        - db
	    environment:
	        - DJANGO_SETTINGS_MODULE=project.settings_docker

as you can see, we are listening to port 9005 and we run our production script. bin/production.sh script just runs uwsgi
bound to specified port from the first argument to the script

	#!/bin/sh

	python manage.py migrate --noinput
	python manage.py collectstatic
	uwsgi --chdir=/code -s 0.0.0.0:$1 --module=project.wsgi:application

And it's done! Just run your containers now:

	docker-compose up 

Deploying API to NGinx
========================

In your Nginx configuration, just add this location:

	location /api/ {
		uwsgi_pass 127.0.0.1:9005;
		include uwsgi_params;
		uwsgi_modifier1 30;
	}

Make sure that all your API urls defined in urls.py begin with "/api/" 

For admin interface, you can do the same but for different location, "admin" instead of "api":


	location /admin/ {
		uwsgi_pass 127.0.0.1:9005;
		include uwsgi_params;
		uwsgi_modifier1 30;
	}

Also, you will have to serve your static files:

	location /static/ {
		alias /path/to/your/app/code/static/;
	}

Deploying frontend
==================

Frontend deployment with NPM is easy, first you have to set up your package.json properly:

	....
	"scripts": {
	  "build:js": "cp node_modules/jquery/dist/* app/dist/ && browserify app/scripts/app.js > app/dist/liberator.js",
	  "build:bootstrap": "cp -rv node_modules/bootstrap/dist/* app/dist/",
	  "build": "mkdir app/dist -p && npm run build:js && npm run build:bootstrap",
	  "clean": "rm -rfv dist/",
	  "lint": "jshint **.js",
	  "prebuild": "npm run lint",
	  "watch": "watch 'npm run build' ./app/ --filter=watch_filter",
	  "serve": "http-server -p 9000 -a 0.0.0.0 ./app/",
	  "livereload": "live-reload ./app/dist/ --port 9001"
	},
	....

And just run 

	npm run build

and your distribution will be held in app/ directory (where dist directory is located) so just configure NGinx to alias to that location:

	location / {
		alias /path/to/frontend/app/;
	}

And that's it! Restart NGinx and enjoy testing your app in production. :)

If you have some suggestions or if you want to remind me on some issues, just fill comment form below. 
