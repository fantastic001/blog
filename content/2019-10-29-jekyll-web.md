Title: Jekyll Web
Date: 2019-10-29 12:15:00 +0100
Slug: 2019-10-29-jekyll-web


Jekyll web is web application made in Django to manage static Jekyll sites from web admin interface.

The main purpose of this web application is to enable people not familiar with Jekyll and command line tools to manage Jekyll sites. Right now, this includes only post management
but in  the future it is planned to have automatic build for building and deploying site as well as management of other things like style, page layout and pages. 

Installation and setup

Installation is simple, you can download source and host it with any web server you want: https://github.com/fantastic001/jekyll-web

When you download sources, you can use it just like any other Django application. The only two things you will have to do:

1. Set up users in sqlite.db database
2. Specify path to directory where Jekyll static site is located. 


Set up users
=============

you can do this by using manage.py provided by Django. Go to source and execute:

	python manage.py migrate
	python manage.py createsuperuser

and you will be prompted with options to create administrator. From there, you will be able to access admin panel to add new users. If you are the only one managing web site, you are okay with just admin user. 

Set up Jekyll static site path
===============================

In `jekyll_web/jekyll_web/settings.py` you will be able to set up path to directory where contents of jekyll static page sources are located. The variable name you will have to set up is: `JEKYLL_PATH`.

Example of settings is:

	JEKYLL_PATH = "/home/me/myjekyllsite/"

Running and usage

Too test if everything works, run:

	python manage.py runserver

and go too URL which you will get in console. You will be redirected to browser and will see welcome message. You can log in by clicking "Log In" in upper-left corner and entering your user credentials which you set up previously. Then, you will be able to access article list and create new article features on upper-left corner.

Conclusion

Right now, it is still poor with features but in the future it is planned to have more supported features. Even though, you will be able to add posts, edit and remove them. Please submit any bugs in Issues tab on GitHub page of project linked above. 


