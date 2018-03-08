---
layout: post
title:  "Easy widgets library for Python based on URWID"
date:   2018-03-08 15:15:00 +0100
categories: python libraries projects
---

Recently I have been developing python library for handling interface in console. The best solution I have found 
was URWID which is used in WICD interface (WiFi manager in console). I wasn't satisfied enough with library 
and I started develping from URWID base to make something easier to use and in this article I will 
explain basic usage of that library. 


Installation
=============


You can install library via pip, just run:

	pip install easy_widgets 

or you can download it from [GitHub](https://github.com/fantastic001/easy_widgets.git). 


Basic usage
===========

First of all, you have to import and initialize library: 

	from easy_widgets import *
	Application.init()

	# whole code goes here 

	Application.run() 

and then you can insert whole code between initialization and 
run lines. 


Adding main menu
===================

There's `Menu` class which can be used for creating menus in applications. This class is subclass of `Widget` which means it has 
`show()` method. Convetion is that all classes which end with `Box` are dialogs and they are shown with `exec()` method while 
other widgets are shown with `show()` method. As you can guess, Box objects are shown like dialogs, keeping parent widgets behind them. In conclusion widgets are shown on whole screen while dialogs are shown only on part of screen keeping parent visible as well. 

`Menu` is of type widget and can be shown with `show()` method. This class also has method `addOption` which recieves function accepting one argument (urwid button instance) and title of item in menu. 

The following example illustrates how to use Menu class. 

	m = Menu("The main menuy")
	m.addOption("Do something", lambda btn: do_something())
	m.addOption("Exit", lambda btn: Application.exit())

	m.show()

Message box
=============

Message box is dialog which is suited for showing messages, you can show it like this:

	msg = MessageBox("Title", "description")
	msg.exec()

or you can add it to main menu:

	m.addOption("Show message box", lambda b: MessageBox("Msg", "This is message box").exec())

Input of text
==============

Text input object is widget object which is aimed to be used 
for text input, it accepts function which is called with entered 
text as its argument, for example:

	TextInput("What is your name", lambda ans: MessageBox("Hello", "Hello %s" % ans).exec()).show()

Wizzards
==========

Wizzard is special object for making wizzards such that you can easily make some kind of setup script, for example wizzard which will print person's name specified number of times:

	from easy_widgets import * 
	
	Application.init()
	
	menu = Menu("Just exit now")
	menu.addOption("OK", lambda b,p: Application.exit())
	
	
	name = ""
	times = 0 
	
	def setName(x):
	    global name 
	    name = x
	def setTimes(x):
	    global times 
	    times = x
	
	w = Wizzard(menu)\
	    .withChoices("Select number", "times", [(1, "one"), (2, "two")])\
	    .withInput("Enter your name", "name")\
	    .withParam("name", setName)\
	    .withParam("times", setTimes)
	
	
	w.show()
	
	Application.run()
	print(name * times)
	
	
Conclusion
===========

This is small library which lets you make awesome stuff quickly and easily. There are many other features, please see `test.py` and `test_wizzard.py` for more examples. This library is also used in Mako's curses client. 
