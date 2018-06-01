---
layout: post
title:  "Parsing in Haskell"
date:   2018-05-07 22:15:00 +0100
categories: haskell compilers
---

This article is going to explain some basic concepts in compiler design and to give practical implementation 
of lexical analysis and parsing in Haskell. 

Compiler design
=================

Every compiler consists of three main parts:

1. lexical analysis 
2. parsing 
3. semantic analysis 

Lexical analysis is responsible for transforming string to list of tokens. Tokens are meaningful objects such as numbers, string constants, identifiers, separators, operators etc. 

Parsing is responsible to take list of tokens and transform it to abstract syntax tree. This tree consists some form of meaning as its node and parameters as children. For example, root node is program node while its children are statement nodes. Every statement node contains children which meaning depends of type of statement. Let's say we have assignment statement, in its children we have one node for identifier and one node for expression. Expression node can be represented by its operator as parent and operands as children etc...

Semantic analysis takes AST and understands meaning to make executable code. Semantic analysis will notify you that you cannot sum string and number. It also does type checking and various things. Semantic analysis is also responsible for keeping track of variables, global, local scopes etc... 

In this article, it will be explained how parsing is done in Haskell using monads. We will assume that we can generate list of tokens from lexical analysis. This will be our input to parser. This list is list of Token type defined like this: 

	
	data Token = Identifier String | KeyWord String | Number Int | StringConstant String | 
        	PlusOperator | MinusOperator | DivisionOperator | MultiplicationOperator | OpenP | 
	     	ClosedP | Comma | Space | AssignmentOperator |
	     	OpenScope | ClosedScope | ListBegin | ListEnd deriving (Show, Eq)

then we need to make parser which will transform list of these tokens into abstract syntax tree. 

Tree description
===================

Tree is represented by its nodes which represent operation and operands as its children. For example if we have expression a + b*c it will be tree with node "+", left child will be identifier "a" and right child will be subtree "*" with left child identifier "b" and right child identifier "c". Another example is a+b+c, where we have "+" as root and identifier "a" as left child and another "+" subtree as right child.

Let's take a look into simple definition of tree nodes for "+", "*", "-" and "/" operations. First of all, let's define them. We know that multiplication and division has priority over addition and subtraction. This means that multiplication and division is always subtree of addition and subtraction. Also, we know that brackets have priority over multiplication and division, so brackets (and expression in them) is always subtree of multiplication and division. For this reason, we will have three types of nodes because we have three levels of priority. 

When we are talking about addition and subtraction, we are talking about expression which has operantor (+ or -) and two operands. One of them is multiplication and another is expression (because we want to have a+b+c). But what if we have only a*b? Then we need to enable that expression can be just one tiny multiplication.
We also have to enable something like "-a" so we will have special kind of negative expression.

Similar thing for term, term is either multiplication, divisio or just factor. 

Factor is just identifier, just number or expression inside brackets. 

To summmarize, our definitions look liker this: 

	expression = term "+" expression | term "-" expression | term | "-" term
	term = factor "*" term | factor "/" term | factor 
	factor = identifier | number | "(" expression ")"

Let's translate this into Haskell code: 
	
	data Factor = JustNumber Int | JustIdentifier String | FactorExpression Expression deriving (Show)
	data Term = MultiplicationTerm Factor Term | DivisionTerm Factor Term | JustFactor Factor deriving (Show)
	data Expression = SumExpression Term Expression | DifferenceExpression Term Expression | JustTerm Term | NegativeTerm Term  |

	

Monadic parsing
===================

Let's assume that we need to parse somehow given list of tokens. What should that operation return? It should return given tree node and the rest of tokens which are not parser. We can model this as state monad where state is list of tokens and output is resulting tree node or something else which we will discuss soon. 

Let's define result of parsing as something that returns result and list of remaining tokens to be parsed or some kind of error: 


	type LineNumber = Int 
	data ParseResult a = ParseResult [Token] a | ParseError LineNumber String deriving (Show)

Now we can make Parse monad which will represent computation of parsing:

	data Parse a = Parse ([Token] -> ParseResult a)
	
	instance Functor Parse where 
		fmap f action = do 
			x <- action 
			return $ f x 
	
	instance Applicative Parse where 
		(<*>) af action = do 
			f <- af 
			x <- action 
			return $ f x 
		pure = return 
	
	instance Monad Parse where 
		return x = Parse $ \tokens -> ParseResult tokens x
		(Parse run) >>= f = Parse $ \tokens -> case run tokens of 
			(ParseResult tokens' x) -> let (Parse run') = f x in case run' tokens' of 
				(ParseError l m) -> ParseError l m 
				res -> res 
			(ParseError l m) -> ParseError l m 

This is a little modified state monad which handles errors inside its run method. 

Parsing
========

Now, how parsing is done? Well, when you see definitions of nodes above, we can use them to easily implement parsing. For now, let's define two functions: 

	getToken :: Parse Token 
	getToken = Parse $ \tokens -> case tokens of 
		[] -> ParseError 0 "Cannot take token"
		t:ts -> ParseResult (t:ts) t 

This function represents computation which returns current tooken as result and does not change state of tokens (this token remains in list of tokens).

Another function is expect which will return parsing error if given token does not exist in list. If it exists, it will remove that token from list of tokens. You can see this function by other names in other articles or literature, for example they call it "eat" somewhere because it "eats" token if it exists. 


	expect :: Token -> Parse Token
	expect token = Parse $ \tokens -> case tokens of 
		[] -> ParseError 0 "Expected token but no such token found"
		t:ts -> if t == token then ParseResult ts t else ParseError 0 $ "Expected token " ++ (show token) ++ " but " ++ (show t) ++ "found"

Alsoo, for outputing errors during parsing, we will have some simple function which always returns error with given message: 

	
	cerror :: String -> Parse a
	cerror msg = Parse $ \token -> ParseError 0 msg

Now, parsing can be done easily from definitions of tree nodes. For example, let's start with factor parsing: 

	factor :: Parse Factor 
	factor = do 
		t <- getToken 
		case getToken of 
			(OpenP) -> do 
				expect OpenP
				expr <- expression 
				expect ClosedP
				return $ FactorExpression expr
			(Identifier name) -> do 
				expect (Identifier name)
				return $ JustIdentifier name 
			(Number num) -> do 
				expect (Number num)
				return $ JustNumber num
			_ -> cerror "Cannot parse factor"

What did we do? Well, we got current token and checked for various possibilities and then handled these possibilities. If nothing is satisfied, we output error. 
You can see how we use expression method (which we will implement later) to easily parse expression inside brackets. We just need to follow our definitions above. 

Let's implement term parsing:

	term = do 
		f <- factor
		t <- getToken
		case t of 
			(MultiplicationOperator) -> do 
				expect MultiplicationOperator 
				tt <- term 
				return $ MultiplicationTerm f tt
			(DivisionOperator) -> do 
				expect DivisionOperator 
				tt <- term 
				return $ DivisionTerm f tt
			_ -> return $ JustFactor f

and for expression:

	expression = do 
		t <- getToken 
		case t of 
			MinusOperator -> do 
				expect MinusOperator 
				expr <- expression 
				return $ NegativeExpression expr
			_ -> do 
				t1 <- term 
				operator <- getToken 
				case operator of 
					PlusOperator -> do 
						expect PlusOperator 
						expr <- expression 
						return $ SumExpression t1 expr
					MinusOperator -> do 
						expect MinusOperator 
						expr <- expression 
						return $ DifferenceExpression t1 expr
					_ -> return $ JustTerm t1 


Conclusion
============

So, as you can see, parsing can be very easily implemented in Haskell Extensions to additional syntax and grammmar can be easily done through adding more methods and tree nodes. 
