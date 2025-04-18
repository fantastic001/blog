Title: A bit of functional programming by example in Haskell
Date: 2017-12-24 12:15:00 +0100
Slug: 2017-12-24-functional-programming


Recently I've started reading about functional programming. When you have been programming using OOP principles 
since you were beginner, it sounds a little bit strange to change approach all the way around. It is scary and sometimes hard. 
As you are older and older, new experiences come hard to gain. In this article I will try to make some clarifications about this 
approach which starts to be a big deal in big software companies as well as startups. It was hard to me to change the way of thinking 
so I am willing to make this process easier for you. I know you've been doing Java or c# for a long time. I know you know the 
bad things in these languages. I know you are sick of OOP or you will eventually be sick of OOP. I will try to explain some pitfalls 
of OOP first and then continue by explaining functional approach and how it solves all of that. I will give examples in Haskell 
but you don't need to be familiar with Haskell to understand examples since they're pretty straightforward and I will give explanation
for things which may seem strange.

Mutability, thread-safeness and history
=========================================


First of all, functional programming is type of declarative programming which means that we explain what is something instead 
of giving instructions step by step which is seen in imperative programming. 
For example, in functional programming we say "factorial of n is n times factorial of n-1 where factorial of 0 is 1". In 
imperative approach, we say how to compute factorial of n: "start with 1 and say result is 1 then increment counter to n and multiply result by counter and save it into result". Here you can see big difference in way of thinking. I personally think that declarative approach is much simpler.

In above example you can see one important difference between these approaches. In declarative programming we define value only once. Translated in language you already know, think of this as using only constant variables instead of common variables which can change state later. This is called immutability which means "when defined once, cannot be changed later". Take a look at the following example of C code:

	#include <stdio.h>
	
	int f( int* x ) 
	{
		int res = (*x) + 1;
		(*x)++;
		return res;
	}
	
	int main() {
		int x = 5;
		printf("%d\n", f(&x));
		printf("%d\n", f(&x));
		return 0;
	}
	
Our function f changes state of x by increasing it by one and returns previous state increased by one. For a moment let's 
forget about this function definition and imagine we only see main function. What would you guess out of it? It seems logical 
that f(x) is always equal to f(x) because mathematically it is logical to one function gives the same value for the same 
parameters. Here we can see this is not the case. This program will output "6 7" which is not logical until we see definition
of function. In functional approach this is not possible at all! In functional approach we cannot mutate state and function 
will return the same output for the same input, ALWAYS! 

Now, you are probably asking why do we limit ourselves to not mutate objects? The answer is because we are undisciplined and 
we need computers to limit us from making mistakes. It is always better to know you have bug when you read compile errors instead of 
seeing end-user complains in bug tracker. 

Another reason why immutability is great is that your program is thread-safe. When you do not change state of anything, you do not have race conditions and your program can be parallelized easily. This starts to be more and more important since we are at saturation 
of Moor's curve and the only way to make computers faster is by adding multiple cores and this can be used efficiently only
if your program supports parallelism. 

Fun fact is that functional programming appeared before OOP. It appeared in 1950's and was introduced in Lisp developed in MIT. The reason why functional programming didn't survive was because, at that time, it was considered slow since architecture of computers didn't 
agree with this concept. OOP seemed as logical approach and was designed for enterprise. Functional programming now is coming back since we have much faster computers and have requirements which fit with this approach (parallelism for instance).


Data-in, data out model
========================

This model has a few principles which makes your code more functional, you can implement this approach even in your OOP
code and make it more thread-safe. These are principles you should follow in your existing projects, no matter what language do you 
use: 

1. Every function returns data 
2. For the same input, function always return the same output
3. When the function is called many times with the same parameters, it ALWAYS returns the same outputs as it was called just once. 
4. Function does not depend on outer environment such as global variables, databases etc...
5. Function does not modify its input. 

Even when you make OOP stuff, try avoiding changing state. For instance, avoid using setters in your class. You can implement your class such that it only has constructor and getter methods. If you want to use setter, setter has to return a new object with changed parameters, not change existing one. 

Example: list in C
===================

Let's take an example where we will implement list of integers in C.

First we will define our list element structure: 

	typedef struct ListElem_t
	{
	        int value;
	        struct ListElem_t* next;
	} ListElem;
	
	

You can see that element hold its value and pointer to next element in a list. This pointer can be NULL which means there's 
nothing after this element.

Now let's create method that will reserve memory for our element and return instance of this element:

	ListElem* create_element(int value, ListElem* next)
	{
	        ListElem* elem = (ListElem*) malloc(sizeof(ListElem));
	        elem->value = value;
	        elem->next = next;
	        return elem;
	}
	
What does this method do is basically reserving memory for our element structure, assigning value to the new element 
from parameters and assigns next element to the element given as argument. At the end, it returns new instance of this element. 

Now we can create our List structure which basically has only pointer to the head of list: 

	typedef struct
	{
	        ListElem* head;
	} List;

Now we will create function that, for a given list element, creates list with head assigned to the given list element: 

	List* create_list(ListElem* head)
	{
	        List* l = (List*) malloc(sizeof(List));
	        l->head = head;
	        return l;
	}
	
Nothing special so far, right? 

Now let's make push method which will add element to the begging of the list. This method will return a new instance of 
list which will have head pointing to the new element while the remaining of the list is behind head so previous head will be next 
element of new head. At the first it seems that we will need to copy whole list and add new element and return this new list. This 
approach is inefficient. The good news are that we do not have to do that. We will need to make new element and new list instance 
which has head pointing to the new element. Next pointer of new element will be just head of our list in arguments so we basically 
do not copy anything. We can do this trick because immutability guarantees that elements of the list won't be changed in any time. 

	List* push(List* l, int value)
	{
	        return create_list(create_element(value, l->head));
	}

Now let's make function that will return new list but without head of a given list (i.e. tail of list):

	List* tail(List* l)
	{
	        return create_list(l->head->next);
	}

If list is not empty, we simply create new list which has head of next element of head of our given list. 
If list is empty, behaviour of tail is not defined so we will end up with segmentation fault (we will try de-referencing NULL pointer).

For debugging purposes we will make print function.

	void print(List* l)
	{
	        if (l->head == NULL) printf("\n");
	        else
	        {
	                printf("%d ", l->head->value);
	                print(tail(l));
	        }
	}
	
So now we can test our list in main:

	int main() {
	        List *l = create_list(NULL);
	        push(l, 5);
	        print(l);
	        List* l2 = push(l, 5);
	        print(l2);
	
	        print(tail(l2));
	        print(push(l2, 10));
	        return 0;
	}


So you can see that when we add element in front of list, we assign this result to the new list since push returns new instance of 
list where it has one additional element. 


Introduction to Haskell 
=======================

Haskell is purely functional programming language. This means that functions receive parameters, do not modify them and always return 
result. This also means that function themselves are first class objects meaning that functions can be passed as parameters and 
returned as result. 

Haskell can be interpreted and compiled. Commonly used compiler for Haskell on UNIX-based systems is ghc and file extension for 
Haskell code is ".hs".

Haskell is strongly typed language which means that types of data are known in compilation time before even running executable. 
Types in Haskell must begin with upper case letter. To test examples, you can run interactive mode with ghci. 

Let's make our first function which takes a number and return square of that number.

	
	sq :: Int -> Int
	sq x = x*x

So we can run this in ghci like this:

	ghci example.hs 
	>>> sq 5 
	25
	>>>

so you can see that we can call function and easily get result. We first declare function by specifying  what types of argument it receives and what type it returns. After that, we can define our function. 

Now let's define function that computes sum of two integers:


	add :: Int -> Int -> Int 
	add a b = a+b

Here we have two parameters and result. The reason we declared function like above is that this declaration is actually not a function 
with two parameters. In Haskell, functions can receive only one parameter and return only one result. Here we have function 
which takes one integer and returns function which takes another integer which then returns their sum. 

This can be easily proven by passing only one parameter to the function:

	inc = add 1

Now inc is function which takes one parameter and returns that parameter increased by one. For instance


	inc 5 

will return 6.

Lists 
==========

Lists in Haskell are implemented like we did above in C. They are simply single-linked lists.

To define list:

	l = [1,2,3]

to get head of the list you can simply do:
	
	head l 

to get tail of list:

	tail l

you can do list concatenation which will merge two lists in a new list:
	
	l = l1 ++ l2

to get list with new element added to the head (our push function):

	l2 = 5 : l

To get list as range of numbers:

	range = [1..10] 

Now we get to interesting stuff: list comprehension! 

This is something you have already seen in math: you can define list by specifying its general element. For instance:

	squares = [x*x | x <- [1..10]]

or you can add additional condition, for instance squares divisible by 3:

	squares = [x*x | x <- [1..10], x*x `mod` 3 == 0]

or to define list of tuples which have property that their distance from (0,0) is less than 1:

	unitcircle = [(x,y) | x <- [0, 0.01..10], y <- [0,0.01..10], x*x + y*y < 1]

Note that I have specified step for our ranges for x and y as well. 


Pattern matching
===================

Something very useful in functional programming languages is pattern matching. Imagine you are trying to implement factorial. First you will check is parameter is zero. If it is, return 1, else return that number times factorial of number decreased by one. 
In Haskell this checking can be easily written using pattern matching:

	fact :: Int -> Int
	fact 0 = 1
	fact n = n * (fact (n-1))

Pattern matching works in the following manner: it will check does arguments of function satisfy first condition, if yes, return given result, else go forward to next condition. 

For example the following function will return 1 if any of its two arguments is zero, 0 otherwise:

	anyzero :: Int -> Int -> Int
	anyzero 0 x = 1
	anyzero x 0 = 1
	anyzero x y = 0


Some list functions 

	mymap :: (a -> b) -> [a] -> [b]
	mymap _ [] = []
	mymap f (x:xs) = (f x) : (mymap f xs)


	reduce :: (b -> a -> b) -> b -> [a] -> b 
	reduce _ z [] = z 
	reduce f z (x:xs) = reduce f (f z x) xs

	myfilter :: (a -> Bool) -> [a] -> [a]
	myfilter _ [] = [] 
	myfilter f (x:xs) = if (f x) then x : (myfilter f xs) else myfilter f xs

	*Main> mymap (+ 1) [1,2,3]
	[2,3,4]
	*Main> filter (\x -> x `mod` 2 == 0) [1,2,3,4,5,6]
	[2,4,6]
	*Main> reduce (+) 0 [1,2,3,4,5]
	15
	*Main> 



Some nice examples
=====================


Function which removes repeating elements

	
	norepeat :: (Eq a) => [a] -> [a]
	norepeat [] = [] 
	norepeat (x:[]) = [x]
	norepeat (x:y:xs) = if x == y then norepeat (x:xs) else x:(norepeat (y:xs))

	*Main> norepeat [1,1,2,5,5,6]
	[1,2,5,6]
	*Main> norepeat [1,1,2,5,5,6, 6]
	[1,2,5,6]
	*Main> norepeat [1,2,5,5,6, 6]
	[1,2,5,6]
	*Main> norepeat [1,2,5]
	[1,2,5]
	*Main> 



Quick sort 

	qsort :: [Int] -> [Int]
	qsort [] = []
	qsort l = (qsort [x | x<-l, x < y]) ++ [y] ++ (qsort [x | x<-l, x>y]) where y = (head l)

Splitting string into words 

	findFirstWord :: [Char] -> ([Char], [Char])
	findFirstWord "" = ("", "")
	findFirstWord " " = ("", "")
	findFirstWord s =
	    let (remaining, others) = findFirstWord $ tail s
	        x = head s
	    in if x == ' ' then ("", tail s) else (x : remaining, others)
	
	split :: [Char] -> [[Char]]
	split "" = []
	split s = let (x, y) = findFirstWord s
	          in [x] ++ (split y)
	

String length 

	strlen :: String -> Int
	strlen s
	    | s == "" = 0
	    | otherwise = 1 + (strlen $ tail s)

Data types 
==========

We can define data types by specifying type name and its constructors. Let's take an example and make Zipper data type. This type
is used mostly in editors. It is basically a list with focused element. You can go left or right and move focus around the list.

	
	data Zipper a = Zip [a] a [a] deriving (Show)
	
	right :: Zipper a -> Zipper a
	right (Zip l focus []) = Zip l focus [] 
	right (Zip l focus r) = Zip (focus:l) (head r ) (tail r)
	
	
	left :: Zipper a -> Zipper a
	left (Zip [] focus r) = Zip [] focus r
	left (Zip l focus r) = Zip (tail l) (head l) (focus:r)
	

now we can do the following:

	*Main> z = Zip [3, 2, 1] 4 [5, 6, 7]
	*Main> right z 
	Zip [4,3,2,1] 5 [6,7]
	*Main> left $ right z 
	Zip [3,2,1] 4 [5,6,7]
	*Main> left $ left $ right z 
	Zip [2,1] 3 [4,5,6,7]
	*Main> left $ left $ left $ right z 
	Zip [1] 2 [3,4,5,6,7]
	*Main> left $ left $ left $ left $ right z 
	Zip [] 1 [2,3,4,5,6,7]
	*Main> left $ left $ left $ left $ left $ right z 
	Zip [] 1 [2,3,4,5,6,7]
	*Main> 

Another example is binary tree node. Note that node can be empty (has no children and no value). Here we are using Haskell's record
syntax which gives us functions for extracting data. This is not usual way for implementing node in binary tree (we can go pretty well with usual data type definition as above) but we show this to demonstrate record syntax. 

	data TreeNode = Node {
	        left :: Node,
	        right :: Node,
	        value :: Int
	    } | EmptyNode
	
	tolist :: TreeNode -> [Int]
	tolist EmptyNode = []
	tolist n = let l = tolist $ left n
	               r = tolist $ right n
	               v = value n
	           in l ++ [v] ++ r
	
	append :: TreeNode -> Int -> Node
	append EmptyNode x = Node EmptyNode EmptyNode x
	append n x = let v = value n
	                 r = right n
	                 l = left n
	             in if x < v then Node (append l x) r v else Node l (append r x) v
	
	
	fromlist :: [Int] -> TreeNode -> TreeNode
	fromlist [] n = n
	fromlist l n = let x = head l
	               in fromlist (tail l) (append n x)
	
	bstsort :: [Int] -> [Int]
	bstsort l = tolist (fromlist l EmptyNode)


Monads
========

In pure functional programming languages, you cannot change state. This is core concept and very powerful one. 
The problem is that our real world needs functionality to change state. Computer architecture is built on idea to change state. 
Even basic operations such as printing to console output require to change state (state of console in this example). 

The way to change state in functional languages is by using monads. Monads are actually mathematical objects which are applied 
to computer science. 

Basically, monad is data type which "surrounds" another type with additional information which is carried through computation. For every monad, we have to define 
two functions: return and bind. 

Function return takes our pure type and returns wrapped type. By using this function, we can convert pure types to our wrapped 
types which hold state. In terms of computation, return does not influence computation.

When we have functions that take one type and return another, it becomes impossible to do composition in standard way. We can
solve this by using bind. Bind function takes our wrapped type and function which takes pure type and returns wrapped type. Bind returns
wrapped type and does following: unwraps our first argument and passes it to function, then "merges" result of a function 
with passed argument and returns it. This is best illustrated with simple example. Let's make type Debuggable which is basically 
integer with list of strings which represents debug info. We first make type Debuggable and then implement bind and ret. Other 
functions are implemented the same way as inc which increases number by one and stores message in a log. 

	data Debuggable = Debuggable (Int, [[Char]]) deriving (Show)
	
	
	ret :: Int -> Debuggable 
	ret x = Debuggable (x, [])
	
	bind :: Debuggable -> (Int -> Debuggable) -> Debuggable
	bind (Debuggable a b) f = Debuggable (y, z ++ b) where Debuggable (y,z) = f(a)
	
	inc :: Int -> Debuggable  
	inc x = Debuggable (x+1, ["Number increased by one"])
	
Note how we do unwrapping and wrapping in bind. There we return our result with concatenated list of debug info from a given parameter
and additional info provided by calling function. 

We are deriving Show here to make our type printable on console. Now we can do something like this: 

	*Main> ret 5 
	Debuggable (5,[])
	*Main> inc 5 
	Debuggable (6,["Number increased by one"])
	*Main> bind (ret 5) inc 
	Debuggable (6,["Number increased by one"])
	*Main> bind (bind (ret 5) inc) inc
	Debuggable (7,["Number increased by one","Number increased by one"])
	*Main> 

Haskell has its own way of defining monads by implementing these operators such that Haskell understands them correctly as monads. 
	
	import Control.Applicative -- Otherwise you can't do the Applicative instance.
	import Control.Monad (liftM, ap)
	
	data Debuggable a = Debuggable (a, [[Char]]) deriving (Show)
	-- needed since newer versions of GHC
	instance Functor Debuggable where
	  fmap = liftM
	
	instance Applicative Debuggable where
	  pure  = return
	  (<*>) = ap
	------------------------
	
	instance Monad Debuggable where 
	  return x = Debuggable (x, [])
	  (>>=) (Debuggable (a,b)) f = Debuggable (y, z ++ b) where Debuggable (y,z) = f(a)
	
	inc :: Int -> Debuggable Int
	inc x = Debuggable (x+1, ["Number increased by one"])

Now we can do something like this:

	*Main> (inc 5) >>= (\x -> (return x) >>= inc)
	Debuggable (7,["Number increased by one","Number increased by one"])
	*Main>

You can see how we use bind operator here. Haskell has syntatic sugar for this and it's called do-notation

	inc2 :: Int -> Debuggable Int 
	inc2 num = do 
	  x <- inc num
	  y <- inc x 
	  return y 

Unit Monad
===========

This is just unit wrapping around type, nothing special: 


	import Control.Applicative -- Otherwise you can't do the Applicative instance.
	import Control.Monad (liftM, ap)
	
	data Unit a = Unit a deriving (Show)
	
	instance Functor Unit where
	  fmap = liftM
	
	instance Applicative Unit where
	  pure  = return
	  (<*>) = ap
	
	instance Monad Unit where 
	  return x = Unit x
	  (>>=) (Unit x) f = f x


Maybe Monad 
============

Useful if you have something which can be "null" or undefined. Value of this type can be something useful or nothing. 


	import Control.Applicative -- Otherwise you can't do the Applicative instance.
	import Control.Monad (liftM, ap)
	
	data Maybe a = Just a | Nothing
	
	instance Functor Maybe where
	  fmap = liftM
	
	instance Applicative Maybe where
	  pure  = return
	  (<*>) = ap
	
	instance Monad Maybe where 
	  return x = Just x
	  (>>=) (Nothing) f = Nothing



IO Monad 
===========


This monad can handle IO operations. In Haskell this monad is special because it changes state of world only with IO object 
provided to main function. Main function is the first function which is run when you compile your program and run it as 
executable without interactive mode. HAHAHAHA I know what you are thinking, we are there babies! We are going to make Hello World!

you can compile your program with:

	ghc hello.hs -o hello -dynamic 

and run it with:

	./hello

and here it is:

	main :: IO ()
	main = putStrLn "Hello world!" 


Let's make small i/o program! 

	main :: IO ()
	main = do
	  putStrLn "Enter your name"
	  name <- getLine
	  putStrLn $ "Your name is " ++ name


Appendix 1: data types
=========================

you can create data types like so:

	data Person = Person {
		firstName :: String,
		lastName :: String,
		age :: Int
	}

and then you can get data from Person value like this:

	fullName p = (firstName p) ++ (lastName p)

or create new value:

	john = Person {firstName = "John", lastName = "Johnson", age=55}

Appendix 2: Interesting links 
===============================

https://downloads.haskell.org/~ghc/latest/docs/html/libraries/

https://hackage.haskell.org/

https://robots.thoughtbot.com/a-rest-api-with-haskell-and-snap


