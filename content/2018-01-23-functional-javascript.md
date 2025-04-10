Title: Functional JavaScript
Date: 2018-01-23 17:15:00 +0100
Slug: 2018-01-23-functional-javascript


In this article I will try to explain some aspects of JS which enable us to write more functional code 
and shorter code as well. 

Node
=====

You can try examples in node, just type `node` to open interactive mode.


Function definitions
======================

Let's explain function definitions in JS:

	function f(x)
	{
		return x*x;
	}

also we can assign function to variables (since functions are first-class objects) 

	> const g = function(x) {return x*x;}
	undefined
	> g(5)
	25
	> 

Objects in JS
=============


Objects are basically dictionaries and are defined like JSON:

	
	> obj = {"a": 1, "b": 2}
	{ a: 1, b: 2 }
	> obj.a
	1
	> obj["a"]
	1
	>

Functions can also be parts of objects. 


Lambda functions 
==================

Since functions are first-class objects we can do this:

	> function filter(arr, f) { 
	... for (var i = 0; i<arr.length; i++) { 
	..... if (f(arr[i])) console.log(arr[i]);
	..... }
	... }
	undefined
	> filter([1,2,3], function (x) {return x % 2 == 0})
	2
	undefined
	> 

arrays have filter function as their method:

	> [1,2,3].filter(function (x) {return x% 2 == 0})
	[ 2 ]
	> 

Also, arrays have map method in them:

	> [1,2,3].map(f)
	[1,4,9]
	>

Also they have reduce (right) method:

	> [1,2,3].reduce(function (z,x) {return z+x;}, 0)
	6
	> 

We can use arrow notation to make our code shorter, for instance:

	> arr.reduce((z,x) => z*z+x, 0)                                                                                                        	12                                                                                                                                     	> 


this hell
===========


Now we will explain constructors which are functions that return objects. 

	> function MyObject() { 
	... return {
	..... a: 1,
	..... b: 2
	..... }
	... }
	undefined
	> obj = MyObject()
	{ a: 1, b: 2 }
	>

In functions, one special (invisible) parameter is also passed: this. Value of this depends on how function is called.

If function is called like f(...) then this refers to global state (i.e state defined by browser or nodeJS environment).

If function is called with new construct: new f(...) then this is empty. 

If function is called as method of some object then this refers to this object: myobj.myfunction() - this refers to myobj. 

Since we here deal with functional approach, we will not consider "new" construct and, when calling functions as methods of some object, will ensure that our function does not modify state of "this". 


Spread syntax
============

Let's suppose we have array called arr: 

if we call function with f(...arr) all its elements will become arguments of function. This 3-dot notation basically extracts 
data from array as normal, comma-separated, values. 

Also, with this syntax we can grab head and tail of array:

	> [head, ...tail] = arr 
	[ 1, 2, 3 ]
	> tail
	[ 2, 3 ]
	> head
	1
	> 

Pattern matching 
==================

Pattern matching is not standardized yet but there's proposal here: https://github.com/tc39/proposal-pattern-matching
