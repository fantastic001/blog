---
layout: post
title:  "Python data structures"
date:   2018-12-05 10:15:00 +0100
categories: dev algorithms
---

Python is very simple and high level language that everyone can learn to prototype their ideas. But this does not come without a price. Because of its high level 
library, it is much harder to know what is implemented inside it. I know that you can now say "well you don't need to know, that's beauty of encapsulation etc..." but when it comes to performance, you should really be careful of what data structures you use. Here in this article I am going to explore few builtin data structures in Python and explain how to implement missing ones. 

Lists ... or are they?
=========================

You probably know about lists in Python, if you don't, here is example:

	l = [1,2,3]

Pretty simple, right? You can access elements by indexing:


	l[2] # will be 3 
	l[0] # will be 1

you can even add elements to it:

	l.append(5)

Now the problem with these lists is that they are not actually lists! I bet computer science professors are angry at Python developers for assigning wrong names to things. Lists in Python
are actually dynamic arrays. They are dynamic arrays of pointers to objects. In C++, one can implement this behaviour using `std::vector` for instance like this:

	std::vector<PythonObject> l;
	l.push_back(PythonObject::Integer(1));
	l.push_back(PythonObject::Integer(2));
	l.push_back(PythonObject::Integer(3));

so lists in Python behave like vector in C++. Accessing elements is fast and adding elements is fast on average. When capacity of array is full, addition will double its capacity and copy contents to new array. 

But what about real lists?
================================

Well, as far as I know, there is no implementation of linked lists in Python. Please correct me if I am wrong down in comment section. Linked lists can be easily implemented and I will explain its implementation now. 

First of all, we will need simple class called `list_node` to represent node of our list. This object will contain value and pointer to next node.Python provides really nice
way to implement such simple class and it is called named tuple:

	from collections import namedtuple
	list_node = namedtuple("list_node", ["value", "next"])
	my_node = list_node(value=2, next=None)

This is implementation of simple node of single-linked list. 

This is implementation of whole container:

	
	class list_node:
	    def __init__(self, value, next):
	        self.value = value
	        self.next = next
	
	class linked_list:
	    
	    def __init__(self, values=None):
	        self.head = None
	        self.first = None
	        if values is not None:
	            for v in values:
	                self.append(v)
	
	    def append(self, value):
	        if self.head is None:
	            self.head = list_node(value=value, next=None)
	            self.first = self.head
	        else:
	            self.head.next = list_node(value=value, next=None)
	            self.head = self.head.next
	
	    def __iter__(self):
	        curr = self.first
	        while curr is not None:
	            yield curr.value
	            curr = curr.next
	
	
and now you can do something like:

	l = linked_list([1,2,3])
	l.append(4)
	for v in l:
	    print(v)

From here, we can implement double-linked list:


	class list_node:
	    def __init__(self, value, next, prev):
	        self.value = value
	        self.next = next
	        self.prev = prev
	
	class linked_list:
	    
	    def __init__(self, values=None):
	        self.head = None
	        self.first = None
	        if values is not None:
	            for v in values:
	                self.append(v)
	
	    def append(self, value):
	        if self.head is None:
	            self.head = list_node(value=value, next=None, prev=None)
	            self.first = self.head
	        else:
	            self.head.next = list_node(value=value, next=None, prev=self.head)
	            self.head = self.head.next
	
	    def __iter__(self):
	        curr = self.first
	        while curr is not None:
	            yield curr.value
	            curr = curr.next
	
	    def pop_last(self):
	        if self.head is not None:
	            self.head = self.head.prev
	            if self.head is None:
	                self.first = None
	            else:
	                self.head.next = None
	        else:
	            raise ValueError("List is empty")
	

Now, other data structures can be implemented from this. 


