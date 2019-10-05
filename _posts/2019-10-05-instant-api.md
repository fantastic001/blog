---
layout: post
title:  "Instant API"
date:   2019-10-05 12:15:00 +0100
categories: python instant-api web rest
---


Today, we live in world of micro services. Now, it is important to make your application accessible to other applications more than ever. The problem is that this task is 
very often easier said than done. We often want to expose some kind of interface to our application. This is usually done using HTTP protocol because there are lot of libraries 
for making HTTP communication easy. This article is about Python library I've made to ease this process. The library is called Instant API and you can find it [here](https://gitlab.com/fantastic001/InstantAPI). 

The idea is to build your API by adding handlers. A handler is some endpoint (actually, it is subset of endpoints in your API) which handles specific type of request. For instance, you can have handler which will handle all endpoints on `/myhandler/` path like `/myhandler/A` , `/myhandler/B/123` etc...

Your API has to have at least one, default handler. Default handler will handle all subpaths that are not handled by some other handler. 

Another thing is type of objects which Instant API uses. These objects are called CloudObjects and you can construct them in Python very easily: 

	myobject = CloudObject(name="somename", age=25)

As you can see, these objects are like dicts. You can specify whatever fields to them. You can get particular field by accessing its attributes:

	print(myobject.name)



Example with simple server with simple file system handler
==========================================================

Here is an example of API creation in Python with one default handler: FSHandler. This handler will handle GET requests which will get content of a file and POST request which will handle writing to file. Since we are working with CloudObject objects, file created will be JSON serialized representation of object.

	from InstantAPI.http import HTTPServer
	from InsttantAPI.handlers import *
	from InstantAPI import CloudServer
	import sys
	
	cloud = CloudServer(FSHandler(sys.argv[1]), handlers=[])
	
	print("Running server on port 8080")
	HTTPServer(cloud, port=8080).serve()

As simple as that. Endpoint for FSHandler is `/data/` so you can try it out with curl: 

	curl -X POST -d '{"name": "John"}' "localhost:8080/data/john"

and you will see file created in directory you specified as first argument to your server (root path where files are served).

Another application can watch for file changes and you will have communication between apps. 

Another example with two handlers
===================================

This is example where we have default handler FSHandler and TimeHandler on endpoint `/time` which will return current time. 


	from InstantAPI.http import HTTPServer
	from InsttantAPI.handlers import *
	from InstantAPI import CloudServer
	import sys
	
	cloud = CloudServer(FSHandler(sys.argv[1]), handlers=[TimeHandler()])
	
	print("Running server on port 8080")
	HTTPServer(cloud, port=8080).serve()

you can try it out with curl:

	curl -X GET localhost:8080/time

and you will get something like:

	{"time": "2019-10-05 13:22:03.206878"}

Current state and extensions
==============

Right now, there are only 4 implemented handlers: FSHandler, TimeHandler, ObjectHandler (handles objects in SQLite db) and JWTHandler (handles authorization). 


You can implement your own handler by inheriting CloudHandler class and implementing handle and handlePut functions. 

	def handlle(self, path, state={})
	def handlePut(self, path, state={}, obj=CloudObject())

These functions will be called on POST and GET requests. You will also need to set `HANDLES` field in your class and put there string with which your handler is 
identified when parsing endpoint path. For instance:

	class MyHandler(ClooudHandler):
		
		HANDLES = "myhandler"
		def handlle(self, path, state={}):
			return CloudObject()
		def handlePut(self, path, state={}, obj=CloudObject()):
			pass

will be called on all paths starting with `/myhandler/`.

You can see source code of existing handlers how are they implemented.

What is state parameter?
========================

When you are initializing CloudServer, in its constructor, you are able to pass state parameter which will be passed to all handlers. This way, handlers can communicate 
with each other using this state mechanism. State can be CloudObject too.

Conclusion
===========

In the future, more handlers will be implemented to minimize need to implementing extended handlers. Also, some kind of composition will be available such that it will be possible to combine small handlers into one complex handler.
