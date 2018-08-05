---
layout: post
title:  "Introduction to computing with CUDA"
date:   2018-08-05 23:15:00 +0100
categories: cuda
---

Recently I have worked on fluid simulation project developed for CUDA-enabled GPU. Here I am going to explain what is CUDA 
and to introduce few concepts needed to start programming on GPU. 

What is CUDA?
=============


CUDA is API developed by NVIDIA to enable communication with its GPUs to use capabilities of their graphics cards to do 
parallel computation. This is essence of GPGPU (General Purpose Graphics Processing Unit). Throught CUDA API, it is possible to access 
and send instructions to GPU and to access its memory. 

Motivation
============

First of all, let's explain why we even need to use parallel computing to do something. For illustration, let's take 
example of particle simulation. We need to simulate movements of huge number of particles in a physical system. Each particle 
has to apply Newton's laws to itself and also to handle collisions with other particles in a system. For each particle to handle 
collisions we need to do O(n) computations which gives as O(n^2) computations for whole simulation step. If we have 100000 particles, it becomes
clear that we have a problem. Each simulation step has to be done in less than 1/30 of second such that we don't have lags in visualization. 
Average CPU core can do 100000000 computations per second which means that our computation will take roughly 100 seconds per simulation step on single core. 
Even if we parallelize computation to 8 cores, we still have speed of one simulation step per 12.5 seconds which is far more than our 1/30 second goal. 

How many cores do we need to make iit under 1/30 second? Well, we would need 100 / (1/30) = 3000 cores. We do not have such CPU with 3000 cores today (and probably we will never have). Device with such greeat parallel computing capabilities is GPU. It has at least 16000 cores that are capable of doing computation. 
Now question arises, how can GPU have so many coores and CPU can't? Well, answer lies in a fact that GPU core has much smaller size of instructions. For instance, it does not support everything which CPU supports and hence needs more instructions to do something which CPU does in only one. Good news are that CUDA-enabled GPU can 
do everthing CPU can but some things can be slower and some things can be faster. 

Back to our example, clearly GPU can solve our problem. We can parallelize our system such that every GPU core gets some set of 
particles and does computation on them. This computation is done in so-called "kernel function" which is function without return value and is 
responsible to do computation per core. It stores its result in GPU memory which can be transfered to CPU later (or never).

Additionaly, in our example, we do not need to transfer data to CPU because we can do visualization already in GPU (good news: we do not lose time on transfering data to do OpenGL drawing for instance). 

CUDA GPU architecture
===================

GPU is divided into blocks where every block contains fixed number of cores. Set of blocks are contained in grid which is used by application. You can learn more about architecture [here](http://www.nvidia.com/content/PDF/fermi_white_papers/NVIDIA_Fermi_Compute_Architecture_Whitepaper.pdf)

Programming for CUDA-enabled devices
=========================================

In this article, it will be presented how to program for CUDA in C++ but you can use other languages too, for instance [Haskell](http://hackage.haskell.org/package/accelerate).

For C++ bindings, you will need nvcc (NVIDIA's C/C++ compiler) and CUDA framework installed. You can find all of these on NVIDIA's website as well as documentation on how to install it.

I suggest to use CMake to build yoour programs because then you will not need to deal with nvcc directly and, trust me, your life will be easier, 
On NVIDIA website you can find CMkaeLists.txt for CUDA [here](https://devblogs.nvidia.com/building-cuda-applications-cmake/).

So our first programs will begin as usual, with main function:

	int main() 
	{
		
		return 0;
	}

And now we will need to compile it:

	cmake . 
	make 

and we will get our result as normal. As you can see, nvcc compiles your programs as gcc does (oh well, nvcc calls gcc). 

Now let's add kernel function and see what new language features nvcc introduces. 

Let's make program for summing arrays, we will need to:

1. make both arrays on CPU 
2. allocate memory on GPU for arrays 
3. transfer arrays to GPU 
4. allocate memory for result
5. call computation 
6. transfer result back to CPU

so let's start:

Make both arrays on CPU
--------------------------

Well, this is easy, we did that billion of times: 

	int a[1000];
	int b[1000];
	for (int i = 0; i<1000; ++i) 
	{
		a[i] = i;
		b[i] = 2*i;
	}

and we are done, next:

Allocate memory on GPU for arrays
------------------------------------

For this we will use cudaMalloc. It works in a way that we provide it a pointer tov pointer which will point to allocated memory on GPU. 

	int *cuda_a, *cuda_b;
	cudaMalloc(&cuda_a, sizeof(int) * 1000);
	cudaMalloc(&cuda_b, sizeof(int) * 1000);

After this, these pointers will point to data in GPU memory so do not try to dereference them on CPU (for instance, you cannot print their content in main function).
You will be able to access them in kernel function because it executes on GPU. 

Well, how can we transfer data to them if we cannot access them? 

Transfer data to GPU
---------------------

Transfering is done through cudaMemcpy function. It is used to transfer data from CPU to GPU and vice versa. 

The first argument to cudaMemcpy is always destination, then source, then size of content and last argument is flag. Flag determines do we need to 
transfer to GPU or from GPU and can be: cudaMemcpyHostToDevice or cudaMemcpyDeviceToHost.

Here we want to transfer from CPU too GPU so we will do:

	cudaMemcpy(cuda_a, a, sizeof(int) * 1000, cudaMemcpyHostToDevice);
	cudaMemcpy(cuda_b, b, sizeof(int) * 1000, cudaMemcpyHostToDevice);

Allocating memory foor result
------------------------------

Process is same ass before, we just use cudaMalloc:

	int res[1000]; 
	int *cuda_res;
	cudaMalloc(&cuda_res, sizeof(int) * 1000);

Creating and calling kernell function
-----------------------------------------

For our sum computation, we will need kernel function. Kernel function iis function which is called in parallel. Since we provide two arrays to it, this means that every core will compute small portion of result: 

	__global__ void sum(int*a, int*b, int* res) 
	{
		int i = blockIdx.x * blockDim.x + threadIdx.x;
		res[i] = a[i] + b[i];
	}

you can nootice that we have used `__globall__` macro which tells nvcc that this function is kernel function which means is executed on GPU but called from CPU. We also can use `__device__` and `__host__` macros to represent functions on GPU and CPU-only. 

Now we can call this function from main:


	sum<<<4,250>>>(cuda_a, cuda_b, cuda_res);

First number in this <<< ... >>> block is number of blocks used and second is number of threads used. Problem with this kernel function is that, if we change number of blocks or threads per block, it won't be coorrect anymore, for instance 1,256 won't work because it will populate only first 256 elements. To solve this, we can use block-stride loop like this:

	for (int i = blockDim.x * blockIdx.x + threadIdx.x; i<1000; i += gridDim.x * blockDim.x) 
	{
		res[i] = a[i] + b[i];
	}

and this is very common pattern to use. 

Synchronization
----------------

After we call kernel function, CPU will continue its execution because kernel is executing on GPU, so we need to wait until kernel function finishes because our next steps depend on result of GPU computation. We can use synchronization for that, after kernel function call:

	cudaDeviceSynchronize();

and this function will block until kernel finishes. 

Transfering result back to CPU
-------------------------------

To transfer result back to CPU we use cudaMemcpy and cudaMemcpyDeviceToHost like this:

	cudaMemcpy(res, cuda_res, sizeof(int) * 1000, cudaMemcpyDeviceToHost);

Now we can print result or do whatever we want with it. 

Best practices
===============

Now when we know how CUDA works, let's list some best practices for it. First of all, if possible, try to maintain data on GPU as long as possible and do data transfers as few as possible because data transfers are costly. Also, if-branching in GPU is very costly so try to avoid it as much as possible. 

If you want to have function which executes on CPU and GPU (`__host__ __device__``) then you can change its code if needed by investigating `__CUDA_ARCH__` macro is defined. For instance:

	#ifdef __CUDA_ARCH__
		for (int i = 0; i<n; i++) 
	#else 
		for (int i = blockDim.x * blockIdx.x + threadIdx.x; i<n; i += gridDim.x * blockDim.x)
	#endif 
		{
			// code
		}

Every CUDA call exposes some error info as its return value so here is the way how to catch it and print it:

	#define cudaCatch(ans) { gpuAssert((ans), __FILE__, __LINE__); }
	inline void gpuAssert(cudaError_t code, const char *file, int line, bool abort=true)
	{
	        if (code != cudaSuccess)
	        {
	                fprintf(stderr,"GPUassert: %s %s %d\n", cudaGetErrorString(code), file, line);
	                if (abort) exit(code);
	        }
	}


so you need to call cuda functions like this:


	cudaCatch(cudaDeviceSynchronize());

and it will catch some errors if they exist and you will be notified on standard output. 

When?
======

Now main question is when to use GPU paralelllization and when to stick to CPU? 

Well, I found that one of the best estimates is how many data transfers you do compared to computation. If ratio of these two is constant, then you are better of using CPU. 
For instance, in our example we do computation of O(n) and do O(n) data transfers so we end up in O(1) ratio. In our previous example with particles, we do O(n^2) computation and O(n) data transfers so we end up in O(n) ratio. 

Sometimes it makes sense to parallelize even when you have constant ratio if that constant is big enough. Try to make code maintainable such that it dooes not need to 
be big effort to paralellize code. 


