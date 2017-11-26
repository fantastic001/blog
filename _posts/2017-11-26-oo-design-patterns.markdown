---
layout: post
title:  "Object-oriented design patterns"
date:   2017-11-26 18:15:00 +0100
categories: agile oop programming software 
---

In software engineering you often need to make some design decisions such that your software is extenable and easily maintainable. 
After some time of software development, industry has come up with repeating patterns of design that makes sense for some application. 
Still, you need to choose particular design pattern but overall task is much simplified because you are deciding on finite number
of patterns with small modifications if needed. I doubt you are trying to solve problem which is not solvable with these patterns
described below. At least, in one part of your software you can use some of these patterns. The purpose if this aarticle is to 
present some design patterns with explanation and examples where they are helpful. In this process, you also have to follow 
[SOLID principles](/agile/oop/programming/software/2017/11/20/SOLID-principles.html).

Here they are: 

Builder
========

This pattern is used when you have to construct object and that object recieves many parameters. It is nice thing to have builder
class that is responsible for object creation. For example, let's say you have some class in which constructor it recieves many parameters. You want to have default values for some parameters. In most programming languages you can define default value for parameter. 
The problem arises if you want to have different default value for parameter A based on passed value for parameter B. Another
case is when you want to have multiple ways of constructing some object and you see you are aving many constructors which basically 
do the same thing in general with little modifications. 

Another use case for builder if you want to build complex data structures or documents. For example, building of XML 
can be implemented with builder design pattern. Building SQL query is another example. 

Another case is when you want to have default parameters and vary them if needed. Take for example this piece of code: 

	MyClass(int a, int b, int c=5, intd=4) ...

What if we want to set values for a,b and d but take c as default. In C++, we need to set value of c such that we are able to set value
of d. 


Builder is implemented as follows: Implement Builder class which in constructor can recieve all its parameters and also has empty constructor which sets up default parameters. For every parameter, implement "setX" method which returns new instance of Builder with changed
specified parameter. Also, you will have to implement build() function which returns concrete object. This class can be used like this:

	MyClass my_object = MyClassBuilder()
		.setA(2)
		.setB(3)
		.setD(4)
		.build();

so every call to set method will return new instance of builder and last call will build concrete object from lastly created builder instance which has all parameters. The real magic comes when you want to make some default values and then create objects with one parameter changed:

	MyClassBuilder builder = MyClassBuilder()
		.setA(2)
		.setB(3);
	
	MyClass myobj1 = builder.setD(7).build();
	MyClass myobj2 = builder.setD(10).build();


Abstract factory
===================

This kind of pattern is used when you want to separate class and its construction. The difference between abstract factory and 
builder is that abstract factory is sublcassed and every subclass implement construction different subclasses of some set of 
abstract classes. For example, you want to have support for multiple coloring systems in your software. You can implement
the following abstract classes: AbstractWindow, AbstractButton, AbstractText. 

For every color you want to have, you subclass and implement these classes. So you will have something like: DarkWindow, DarkButton, DarkText, LightWindow, LightButton and LightText. 

So now you want to use dark buttons only with dark windows. These classes share the same interface but construction is different. 

This can be easily solved using abstract factory and then having in its interface the following mmethods: getutton(), getWindow() and getText(). 

so then you can subcass this class and makeDarkFactory and LightFactory, every in its implementation returns needed class instances for
button, window and text. Now you can use it like this:

	AbstractFactory theme = DarkFactory()
	AbstractButton btn = theme.getButton(); 
	AbstractWindow win = theme.getWindow();

	...

when structuring all this in directories, pay attention to put concrete factory and objects which are created by that factory at the same place if possible 

this is best done when we use only one instance of factory in system, factory can be provided from singleton or something like that. 

Adapter
==========

Class which recieves one object in its constructor and converts it to other objects by its methods 

This pattern can be used to: 

1. convert one object to another 
2. to make glue between different, non-compatible parts of software
3. wrap existing class with a new interface: recieves object in constructor and exposes new interface
4. match legacy component to a new system 
5. match new component to a old system


Composite
==========

Tihs pattern is used when we want to compose some objects in a group. For example, in graphical user interface, Window object 
is of composite type. When we move window on screen, all widgets on that window are also moved. It is implemented very easily. You 
can pass inner objects using constructor, using Builder, abstract factory or by invoking some kind of add(CompositeChild) method.

Decorator
==========

Used to add functionality to individual objects and when needed features grow exponentialy as number of small features grows.

Basically, it has same interface as class it is decorating and in every method, method of decorated object is called with additional actions above and below calling this method of concrete object(). For example we want to make some kind of simulator. We want to 
implement later some kind of logging. We can make decorator class which, before calls its child's method, write log in a file
or to the standard output. The we just need to decorate our existing simulator object:

	Simulator* simulator = new Simulator(); // logging turned off 
	simulator = new DebugDecorator(simulator); // we turn on logging

hain of responsibility
=========================

This kind of pattern is used when we want to implement some kind of checking or multi layer processing. 

How does it work? Define abstract Process and implement individual processes. Implement method process() or check() and implement method getNext(). 

Now we have to implement our class which is chain of responsibility. It gets specific request (object to handle, object to check etc...)
and it passes this request to processes. It first starts at root process and then calls getNext() method of root process and then passes request to next process and so on until it gets to the end of chain. 

This concept can be handy in parsing and creating trees or lists. 

use cases: 

1. middleware classes that control security
2. pattern recognition - recognize pattern in data and return aproprirate object to handle it (or proper Factory) 


Command
=======

Tihs is used hand-by-hand with previous pattern. Tihs command is basically process. You have to make one abstract interface 
for command and then implement individual commands. These individual commmands can recieve additional parameters in its constructors
or can be gained from some factory.

Also, this pattern is useful if you want to make "undo" operation. Every command instance changes state and every 
class implementing Command interface has to implement undo() method. After that, you just have to save history of commands 
(which is basically list of Command instances) and when you want to invoke undo functionality, just call undo() method of lastly
executed command and remove it from list. 

Observer 
==========

In this pattern, there is two types of classes: observers and subjects. Subject observes state (which is usually its own state)
and notifies observer when state is changed. 

One common example is Subject which keeps data model, Observers (views) register to that subject and watch for changes. This is 
often used in MVC (Model-View-Controller) architecture which is often used in GUI applications and web frontends. 

Strategy 
=========

Here we have one abstract class and other classes inherit it.
Abstract class defines interface and each class implements it.

For example, different algorithms which solve the same problem. 

Template method
================

This is often used when we have some kind of algoritmh with multiple steps and every step can be implemented differently. 
In this case, we can make class which recieves different Strategy instances for different steps. For example, in speech recognition
we can have feature extraction and model fitting. We can make FeatureExtractionStrategy and implement concrete strategies for 
feature extraction and then we can also make ModelFittingStrategy and implement concrete model fitting algorithms such as 
neural networks, HMM etc... 

Conclusion
==============

This is very limmited set of design patterns, you can find a lot of examples and descriptions online. I do not recommend reading
books about this topic because this stuff is best grased by practice and real world examples and real world projects. You can 
look at open source software and see how others do things and get some idea of how you could start your design process. 


