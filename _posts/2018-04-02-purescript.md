---
layout: post
title:  "Purescript - a nice path to web"
date:   2018-04-02 23:15:00 +0100
categories: haskell purescript web
---

Recently I have been playing with Haskell and functional programming. I've found a nice Haskell-like language which compiles to Javascript which means 
it is very suitable for web. It is PureScript and you can easily set up project with pulp and run it. It can be used to develop backend part or frontend part. 


Installation of tools 
=======================

Tools needed for purescript project can be installed via npm:

	
	npm install pulp purescript bower

Most of purescript packages can be installed with bower, for example AFF library:

	bower install purescript-aff 


pulp is PureScript's equivalent of gulp and it is used to run, build and initialize project. It can be also used to generate javascript code which can be 
linked to HTML. 


After installation, you should add pulp to path:

	export PATH="$PATH:node_modules/.bin/"

Now you can initialize project:

	pulp init 

To generate JS file:

	pulp browserify -t script.js 

To build project and run:

	pulp run

To launch REPL with project's environment:

	pulp repl

===Learning PureScript===

If you know Haskell you will easily understand PS, just see [what is different](https://github.com/purescript/documentation/blob/master/language/Differences-from-Haskell.md).

===Building UI with PS===

There's nice module for PureScript where you can easily build reactive UIs. It is called Halogen and [here](https://github.com/slamdata/purescript-halogen/tree/master/docs) you can reed guide to it. 

===Building backend===

There is wrapper around node-express for purescript and [here](https://abhinavsarkar.net/posts/ps-simple-rest-service/) is simple guide to it. 
