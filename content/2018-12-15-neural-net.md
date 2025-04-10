Title: Neural networks are not too hard to understand theoretically
Date: 2018-12-15 10:15:00 +0100
Slug: 2018-12-15-neural-net


Most "experts" today use neural networks like it is black box and think they are going to solve every problem they have. Deep learning and other concepts are considered as hard and advanced. Reason for this "advanced concept" thinking is because most programmers do not really understand neural networks as mathematical model. Neural network is just function which we fit to better represent our data. Neural network training is not different from, for instance, fitting linear function and in this article I am going to show why. 

So let's start from basics here: 

Finding minimum of function
==============================

Let's say we have function f(x) which we need to minimize such that to find x0 that satisfies condition f(x0) < f(x) for any other x near x0. We can do that by using analytical 
methods of derivatives etc. This works for functions for which we can easily calculate roots of derivatives. If we do not know how to calculate derivatives, we need to move on 
to numerical iterative methods. Iterative method starts with initial guess and updates that guess based on formula: $$ x_{t+1} = x_t + \Delta x (x_{t}) $$ where $$ \Delta x $$ is 
some function depending on method. 

Newton's method: $$ \Delta x = - \frac{f'(x_t)}{f''(x_{t})} $$ 

Gradient method: $$ \Delta x = - \alpha f'(x_{t}) $$ 

We can extend this to more variables, then x is vector and f is multivariate scalar function. Now our iterative algorithms look like this:

Newton's method: $$ \Delta x = -H^{-1}f(x_{t}) \nabla f (x_{t}) $$

Gradient algorithm: $$ \Delta x = - \alpha \nabla f(x_{t}) $$ 

As we can see, gradient algorithm is computationally easier to calculate and is faster than Newton's algorithm. Reason for that is that gradient algorithm does not 
calculate Hessian matrix which grows quadratically with dimensionality of x. Gradient algorithm, instead, approximates Hessian by scalar alpha. 

In the rest of article, we will use gradient algorithm to implement iteration of updating current variable to new state. 

Function fitting
=================

Now let's assume we have multivariate scalar function with unknown parameters. We want to estimate those parameters such that that function approximates our data. 

In other words, we want to minimize error: $$ E = \frac{1}{2} \sum_{n=0}^K (y_{n} - f(x_{n}, w))^2 $$ where w is vector of parameters and xn is nth training point while yn is 
expected value of function of nth data point. Now we need to find vector w such that we minimize that error (to make f as close as possible to y's). We can apply our gradient 
algorithm to update w. We start with some initial guess and update w as follows: 

$$ w_{t+1} = w_{t} - \alpha \nabla E(w_{t}) $$ 

now, we need to calculate gradient of our error function: 

$$ \nabla E = \frac{1}{2} \sum_{n=0}^K 2 (f(x_{n}, w_{t}) - y_{n}) \nabla f(x_{n}, w_{t}) $$ 



and that's it, we also need to calculate gradient of our function f such that our algorithm is complete and we will do that after introducing what our function f is. 


Our function - neural network 
===============================


Now, let's consider simple neural network with one input layer and one output layer (without hidden layer). Let's say we have N nodes in input layer and M nodes in output layer. now we have M functions to calculate: 

$$ f_{m} = \sum_{i=0}^N w_{i,m} x_{i} $$ 


oh wait....is this linear regression? Yeah....


but wait again... we said earlier that our f is scalar function but here we say that neural network has M output nodes, WTF??? Well, we can still update our weights, just with slightly modified gradient of error: 

$$ \nabla E = \sum_{n=0}^K (f(x_{n}, w_{t}) - y_{n})\nabla f = \sum_{n=0}^K \sum_{j=0}^M (f_{j}(x_{n}, w_{t}) - y_{n,j}) \nabla f_{j} $$ 

Now we are back in the game, we just treat this product as scalar product and we are fine. It can be proven mathematically that this is correct assumption but here there is no need for it. 

Now, as we have calculated this error gradient, we just need to calculate gradient for every possible function. Well, this is easy: 

$$ \frac{\partial f_{j}}{\partial w_{i,j}} = x_{i} $$ 


"Advanced stuff"
===================

All other, advanced neural networks are still some kind of function f, in next article I am planning to explain this topic further by investigating more complex neural networks. 




