---
layout: post
title:  "Algorithm analysis in functional programming"
date:   2018-01-16 23:15:00 +0100
categories: functional-programming software algorithms
---

This article has purpose to demonstrate the way of reasoning when algoritmh analysis comes for programs written in 
functional programming paradigm. I will give some examples in Haskell to demostrate methodology and also explain some
core theorems in algorithm analysis. Here I will focus especially to time analysis in asymptotic manner which is when 
we take limit where size of input goes to infinity. 

List comprehension
==================


Firt let's start by simple things. List comprehension is a way to define new list in terms of existing one. It is similar to what 
you can see in math. For example the following list:

	l = [x^2 | x <- [1..10]]

is a list of squares from 1 to 10 (it is list [1,4,9, ..., 100])

List comprehension is done in O(n) time. Another example is finding prime numbers:


	primes = [x | x <- [1..100], [y | y <- [2..x-1], x `mod` y == 0] == []]

This is list of primes from 1 to 100. Let's determine what time does it take to find prime numbers from 1 to n using this method. First 
we need to generate list of n numbers and for each to check is list [y|y<-[2..x-1], x `mod` y == 0] empty. To generate this second
list we need to check x elements. This yields formula: 1 + 2 + ... + n which is asymptotically equal to O(n^2).

Here you can see that filtering does not lower number of operations since we have to perform them anyway. 

Recursion
==========

Analysis of recursive functions is not the same as in imperative programming. In imperative programming every call to 
function is executed while in functional programming, call to function with specific parameters is executed only once! 

We can check that in the following example:

	fact :: Int -> Int 
	fact 1 = 1
	fact n = n * fact (n-1)

so if we calculate fact 100 and call it again, or call fact 99 we will get result immediately. Tihs is because in functional 
programming, function always returns the same result when called with the same parameters so this can be cached. This 
is good for us when worrying about time but may be bad if we worry about space. This complicates our time analysis 
For example, consider Fibonacci number generator:

	fib = 0 = 1
	fib 1 = 1 
	fib n = fib (n-1) + fib (n-2) 

if we apply our analysis and know that results are cached, we get total execution time of O(n) since values won't be computed twice. 

Operations on lists
====================

We will have to consider some operations for list and to be aware of their time performance. The most used 
operation is adding to the head of list: x:xs is a new list with its head x and tail xs. This operation 
takes constant time since Haskell implements lists as single-linked and saves pointer only to the head of list. 
We are not copying whole list, we are just returning new head of a list. 

We using concatenation with ++, then we have O(n) complexity and explanation is that lists are single-linked and we have
to traverse list and make copy of elements to be able to create concatenated version. 

Operator !! which will give n-th element in a list takes also O(n) time since it is property of a list. 

Quick sort example
===================

Let's do the analysis for our quick sort example:


	qsort :: [Int] -> [Int]
	qsort [] = []
	qsort l = (qsort [x | x<-l, x < y]) ++ [y] ++ (qsort [x | x<-l, x>y]) where y = (head l)

first we will do list comprehension for left and right part and it takes O(n) time and then we will merge results of sorting individual parts which also takes O(n) time. For sorting both sides we need 2T(n/2) time if we assume that left and right sides are approximately equal. Now we have formula:

	T(n) = 2T(n/2) + O(n)

so by Akra-Bazzi theorem we conclude that T(n) = O(nlog(n)).
