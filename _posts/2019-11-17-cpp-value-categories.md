---
layout: post
title:  "C++ Value categories - making your constructors time and memory optimal"
date:   2019-11-17 15:15:00 +0100
categories: python web Jekyll
---

Since C++11, a lot of effort is invested in optimizing code for performance. The bottleneck was always copying stuff around and making temporary objects. Since we do not want to come back to CC, in C++11 there is functionality to distinguish if we are passing temporary object or object we will use later. 

As you can see, it is important to understand that we are not concerned about parameter type in function but also about if it is temporary object or not. 

For this reason, there is concept of value category. Value categories existed long before C++ came to this world, one cannot use everything on left-hand side of assignment operator. For instance, the following code in C will be semantically okay:

	int a; 
	a = 5; 

"a" is variable of type int, operator `=` expects an int on left and an int on right hand side. On the other side, the following code will produce compile error:

	int a; 
	5 = a; 

Type semantics are okay here as well: two ints on both sides. The problem is that value category differs. Variable `a` is called lvalue while number 5 is called rvalue. When we are using operator "=", we have to put lvalue on left hand side. 

# Value categories in C++

In C++, there is huge difference to C. In C, we had two value categories: lvalue and rvalue. These are categories which specify what kind of values can be on left-hand side of assignment operator (and on right hand side as well) and what can be on right-hand side only. 

In C++, we have three primitive value categories:

1. lvalue (same as in C)
2. prvalue (primitive rvalue)
3. xvalue (eXpiring value) - used for temporary objects which will be deleted very soon (most probably in the next statement).

Now, there are some generalizations:

1. rvalue = prvalue or xvalue
2. glvalue(i.e. generalized lvalue) = lvalue or xvalue 

So, xvalue is rvalue and glvalue at the same time. 

So, lvalue is everything which is addressable. When you want to know if something is lvalue, ask yourself if you can get address of that object. For instance, variables are lvalues because we can get address of them while `5` is not lvalue since we cannot get address of it in memory (it is not explicitly stored in memory).

The tricky part is the following: string constants are lvalues! Same rule applied: we can get address of them since they are stored in memory even though they are not variables. 

If we get address of lvalue, it is prvalue since that address is not stored. If we store that address to pointer variable, then pointer variable is lvalue, of course. 

Also, when using `new` operator for memory allocation, it is stored in memory (we have just allocated space for it) but we cannot reference it unless we save it to variable. So, what is value category of expression with `new` operator? It is stored in memory temporally, so it is xvalue. 

everything else is prvalue. 

Attention! `this` pointer is also prvalue, even though it is variable. The reason for this is it is stored in register on most architectures rather then in memory, so address of it cannot be read. 


# Telling functions which value categories are permitted 

Since some expression has no only type but type and value category as a pair, we are able to say what type and value category of parameter has to be. 

## lvalue references

If we want to permit only lvalues, we can make function with `&` added to its parameter to tell it can receive only lvalues:

	int my_function(int& a) {
		a = 5; // a is changed also outside of scope of function, reference to variable is copied instead of whole value
	}

So this behaves like raw pointers in C. 

Also, we can assign some variable to lvalue references as well:

	std::string mystr("my string");
	std::string& ref = mystr;

## Const references

If we do not want to copy whole value (like we did in lvalue references) but still want to be able to pass rvalues, we can make our lvalue reference constant. That means we won't modify it inside function (if we do, we will get compile error):

	int count_spaces(const std::string& str) {
		int c = 0;
		for (int i = 0; i<str.size(); i++) {
			if (str[i] == ' ') c++;
		}
		return c;
	}

## rvalue references 

Now, we can make function which can get only rvalues. This is introduces in C++11. This is important because sometimes we want to distinguish between lvalues and rvalues. 

	std::string& make_copy(std::string&& str) 
	{
		return str;
	}

	std::string& make_copy(std::string& str) {
		std::string* str2 = new std::string(str);
		return *str2;
	}

## old-fashioned copy way 

And, finally, we have old-fashioned way with copying, we copy whole value and as such, our function can take lvalues and rvalues and value will be copied:

	int copy_function(sstd::string str) 
	{
		// .. 
	}

# move semantics for constructors 

Now, as we can have different implementations of the same function for rvalue and lvalue. This means we can have constructors which do copy (in case lvalue is received) and constructors which do move (in case rvalue is received). 

	MyClass::MyClass(MyClass& other) 
	{
		// do copy here
	}
	MyClass::MyClass(MyClass&& other) {
		// just move pointers here
	}

Now, what if we want to move existing, already stored in memory, variable? If we just pass it, it will be passed as lvalue and hence copy constructor will be called. How to force move? Well, we need to cast it to rvalue. Here, `std::move` is useful function, it receives lvalue reference and converts it to lvalue reference:

	MyClass obj;
	// .. use obj 
	MyClass obj2(std::move(obj));
	// now obj cannot be used anymore

# how std::move works 

`std::move` is function which heavily abuses meta programming capabilities of C++. In compile time, it casts passed object to rvalue reference of the same type. It first removes reference with `std::remove_reference` meta function and adds `&&` to type and returns casted value. 

# std::forward explained

Since, when we use parameters in a function (whatever value category it is passed as), maybe we want to forward that parameter to another function and, if we just forward it as normal argument, we will always pass it as lvalue. Now, we need to cast it to value category based on which parameter it was in our parameter list. We can do it manually or we can use `std::forward` to do it for us. So, like std::move converts lvalue to rvalues, std::forward will convert lvalues to anything it was before (value category of argument).

# Conclusion


In conclusion, it is important to understand value categories in C++ since it will enable you to write more efficient code and make better performance related decisions. Use move semantics wherever possible. 




