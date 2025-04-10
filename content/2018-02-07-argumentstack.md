Title: ArgumentStack
Date: 2018-02-07 15:15:00 +0100
Slug: 2018-02-07-argumentstack



ArgumentStack is a small python library which helps you to make argument parsing easy. It is based on nice argument 
structure where your arguments are structured like a tree. Nice example of this is nmcli command for network manager, for instance you can do:

	nmcli dev 

and it will list all devices, but if you do:

	nmcli dev wifi 

it will list only wifi devices which are scanned. However if you do:

	nmcli general 

it will show general status info. Similar example is Mako, if you do:

	mako projects 

it will show list of projects currently in database, but if you do:

	mako project X subprojects

it will show X's subprojects. ArgumentStack functionality is based on adding arguments to stack and then assigning action for 
current stack state. It supports push and pop functions for stack. For example, in nmcli part we would implement above functionality 
like:
	
	from ArgumentStack import * 
	import sys 
	
	# define needed functions as actions 
	
	stack = ArgumentStack("Wrong command") # to constructor it is passed error message for non-existing commands
	
	stack.pushCommand("dev")
	stack.assignAction(dev_status, "device status") # nmcli dev
	
	stack.pushCommand("wifi")
	stack.assignAction(wifi_scanned, "WIFI device list") # nmcli dev wifi 
	stack.pop() # now state is: nmcli dev 
	
	stack.pushCommand("ethernet") # nmcli dev ethernet
	stack.assignAction(ethernet_status, "Ethernet status")
	stack.popAll() # now state is: nmcli
	
	stack.pushCommand("general")
	stack.assignAction(general_info, "General status info") # nmcli general 
	
	stack.pushVariable("interface")
	stack.assignAction(info_for_interface, "info for interface") # nmcli general <interface>
	# interface is passed as keyword argument to function info_for_interface
	
	sys.execute(sys.argv) # argument parsing and calling apropirate functions

Important note here is that our functions have to take keyword arguments such that variables can be passed (as our interface variable for general action, last state).

You can make action for getting help, for instance, above stack.execute(...) call just add:

	
	stack.popAll()
	stack.pushCommand("help")
	stack.assignAction(lambda: print(stack.getHelp()), "Get help")

Example using lambda expressions
===================================

You can use lambda expressions if your functions are one line of code:
	
	#!/usr/bin/python 
	from src import * 
	
	
	import sys
	stack = ArgumentStack("Wrong command")
	
	stack.pushCommand("hello")
	stack.pushCommand("world")
	stack.assignAction(lambda: print("hello world!"), "say hello to world")
	stack.pop()
	stack.pushCommand("to")
	stack.pushVariable("name")
	stack.assignAction(lambda name: print("Hello, %s" % name), "say hello to somebody")
	stack.popAll()
	stack.pushCommand("help")
	stack.assignAction(lambda: print(stack.getHelp()), "Get help")
	stack.execute(sys.argv)
	
Installation 
===============

ArgumentStack can be easily installed via pip:

	pip install ArgumentStack 
