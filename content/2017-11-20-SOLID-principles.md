Title: SOLID design principles
Date: 2017-11-20 23:15:00 +0100
Slug: 2017-11-20-SOLID-principles


In this article it will be explained one design process which really fascinated me and held me awake during nights while 
thinking of how much is it cool and powerful. First of all, these principles are set of design decision during software development
which are intended to boost maintainability of software and make software development continuous and easily 
adaptable to new specifications by its users. 

This set of principles is promoted by Robert C. Martin. He's fascinating man and you should watch all of his talks. This 
guy knows what to say and how industry works. He knows that he is talking about, really. 

So, I will briefly explain every principle with examples of how are they applicable to concrete cases. Let's start:


Single responsibility principle
================================

This principle tells us that class in particular module should have only one responsibility. This means only one reason to change. 
Think about it as follows: if you have class A in your module and, let's say, your CFO tells you new specification that causes 
changes to class A. In the same time, your COO tells you additional requirement and you have to change class A again. 
You can see that you are changing class for different reason. Two different departments have requirements that cause change to the
same class. When you are in this situation you can guess that you are not satisfying this principle. 

Let's say particular example how to make this right. Let's say you want to calculate something, for example to generate 
some kind of report to the user. You will make three classes. One class will represent structure of the report, another class
will generate our report object and last one will format it and show it on console or in graphical user interface. 

You can go further by having multiple classes for generating different parts of report and then you combine these classes 
to create final report. 

Open/closed principle
======================


This principle basically says that design should be open for extensions and closed for modifications. This means it is better 
to add new feature by adding new class than by changing existing classes. For example, you are developing some kind of software 
that will compute something based on different methods. This could be some machine learning software or bot for games. In the
future, you want to support adding additional algorithms. You should implement every algorithms as separate class that share common
interface. This nicely picks on above principle because if you have, for example, interface for report view class, you can add
additional view by adding additional class, not by modifying existing classes. 


This is easily done by inheritance. You should never change class, especially its interface which is seen by user. 

One way to achieve this is by making abstract class for one process or operation and to implement this class for particular case. 
You should abstract everything and soon you will see that new features are handled by adding stuff, not changing existing stuff.

If you use some framework for GUI, abstract its behaviour and implement concrete class using this framework. When you want to 
change framework, you basically add new implementation of abstract class. Same thing goes for databases and for 
file formats. If you make networking application which uses some kind of protocol, make abstract class for that protocol and
implement concrete protocol. When you want to support new protocol, you will be able to add just another implementation
of your abstract class. If you are developing application that needs to render 3D, you can make abstract class for 3D engine and then 
implement concrete engine you want. If you want to change engine, you just add another class. 

One more thing, let's say you want to add additional functionality to every 3D engine you support. This in some sense requires changing
existing stuff but you will do it nicely. You just need to add additional method to abstract class and implement that method
in its subclasses. This does not require that you change existing methods. 

Liskov substitution principle
===============================

If if have two classes. One T and one S which is inherited from T. This principle says that we always can replace objects of type T
with objects of type S and we will maintain correctness of a program. 

So, what this actually mean? Let's say we have our two classes mentioned above. Every method of T has its own preconditions, 
post conditions and invariants. 

Your subtype must satisfy the following criteria:

1. Preconditions cannot be strengthened in a subtype.
2. Post conditions cannot be weakened in a subtype.
3. Invariants (conditions held true) of the supertype must be preserved in a subtype.
4. immutability cannot be subtyped to mutable class 

Let's say we have class Rectangle and then we make subclass Square. This breaks Liskov substitution principle because 
Rectangle has two methods: setHeight and setWidth. The problem is when user calls setHeight, he expects that width is not changed
which is happening with Square objects. This can be solved by separating these two as different types and not using inheritance
for this kind of thing. Maybe it seems logical that Square should be subclassed from Rectangle but this kind of 
design breaks this principle. If it is needed to have common type for Rectangle and Square then the right interface can be 
Drawable since we are probably talking about drawable objects. 


You can always use only immutable objects to make this requirement easy to maintain. This is because immutability does not break 
this principle. 


Interface segregation principle
==================================

This principle basically states that it is better to have more small interfaces than one big interface with all methods. 
One example which demonstrates breaking of this principle is when you try to design system capable of reading and writing multiple file
formats. The problem arises when you have file formats which you want to support only reading. Of course, you can 
fake writing methods using "pass" in Python for instance. The problem with this approach is when someone else uses your class, it is
visible to the user of class that there's write method and user does not know if it is implemented or just fake. The solution
to this problem is to make two interfaces: Writable and Readable. If you want to implement both reading and writing, you just implement
both interfaces but if you want to implement only reading, you can do so without implementing writing. 
Now, in your save() function, you need only Writable and in your open() function you need only Readable. Someone who does 
implementation of save or export functionality, does not care and does not know about writing methods. The user of Readable sees
only methods for reading.

Dependency inversion principle
===================================

This principle states that high level modules shouldn't depend on low level modules. This seems confusing at first. The key
thing here is to use abstract classes and interfaces. Both low level and high level modules depend on interfaces. Low level 
modules inherit and implement interfaces while high level modules use these interfaces (no matter what implements them).

Classical example is when you try to implement file browser and you want to support multiple file systems or remote file browsing
like FTP. The idea here is to make browsing interface which will call concrete implementation if needed. 

The most popular pattern which supports this principle is MVC (Model, View, Controller). In this scenario, different modules
handle data representation, graphical interface or data visualization and data handling and manipulation. 


Conclusion
=============

Sometimes it is hard to follow all these principles. Also, new (old) paradigms arrive such as functional programming which aims to solve
some problems we are facing with OOP. At least, when you try to follow these principles, you have better software development and 
you make changes really quickly. If you are lazy, this is thing for you, trust me. I am lazy and I love when I don't need to code
so much.
