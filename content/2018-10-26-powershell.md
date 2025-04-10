Title: Powershell - next generation shell
Date: 2018-10-26 10:15:00 +0100
Slug: 2018-10-26-powershell


Recently I started using Powershell which friend of mine recommended. Powershell is Microsoft's product built on .NET platform which introduces .NET functionality in interactive 
interface. When I say interactive I mean both console and GUI but here we will consider only console aspects of powershell and I won't discuss powershell host development. (maybe in future articles)

As we know, standard way of thinking about console applications is there is 3 channels of communication to user: standard input, standard output and standard error. We send character sequence
to standard input and receive character sequence to standard output and standard error. All 3 channels are character-based which means we get information as array of characters. 
This approach is used since late 60s and is used now and nothing has been changed. Main reason for this situation is compatibility with legacy apps. If you are a developer, you probably use Vim, Emacs, GCC, etc... and you know these tools are developed  20 or 30 years ago. Still, they are so powerful that they are still used now. The problem with this approach is that we face day-to-day challenges where we need to combine these tools such that we can do complex operations on our systems. This becomes more and more challenging since we need to interface two or more 
tools to do that. Solution has been developed also in previous century and it is shell pipe-lining. For instance, let's take example that we want to filter lines in file containing "FILTER ME" and then replace all appearances of "REPLACE ME" with "REPLACED". We have one tool to get contents of file, another tool which reads standard input and outputs filtered lines to standard output and another tool which reads from standard input and outputs to standard output every line with replaced text. 

For reading files, we can use tool called cat. For filtering we can use tool called grep and last but not the least, for replacement we can use sed. Now we use cat to output file contents to standard output, then we take that standard output and add it to standard input for grep which outputs filtered lines to standard output. Now we take standard output of grep and bring it to standard input of sed to get final result on standard output which is showed as result on screen. 

	cat file.txt | grep "FILTER ME" | sed "s/REPLACE ME/REPLACED/g"

Now, let's consider slightly complicated problem. Let's say we have file containing list of filenames and we want to replace appearance of ".txt" with ".text" and then create all of them. We can do this by running:

	cat files.txt | sed "s/\.txt/.text/g" | xargs -n1 touch 

so what does this command do? Let's go piece by piece. First we get contents of the file to standard output, then we replace needed stuff and finally we call touch which is tool that makes files. The problem is that touch receives command line arguments instead of reading from standard input so we need tool which traverses line by line of standard input and calls touch for every line passing that line as argument to touch. This is why we need to use xargs. 

Now let's take even more complicated problem: we want to rename all files which satisfy condition that their name ends with ".txt" and are not readable by others. Now we can use command "ls" to get information about files but since we are getting text to standard output, we will need to parse that output first to get some kind of ability to filter and map stuff. Now we start to see disadvantages of text stdin,stdout and stderr approaches. Powershell solves this issue by introducing objects instead of sequence of characters. 

Powershell solution
=====================

Powershell solved this problem by introducing that, instead of pure character-based standard output and standard input, we use object-oriented approach. Now on standard output and on standard input, there are objects instead of basic text. Now you can ask, what about legacy apps? Well, Well their output is represented as list of strings where each string is one line while objects in standard input are converted to strings and sent to these apps. 

So, Powershell enables you to use everything which you could use earlier in other shells and adds additional functionality. Powershell has its own commands called commandlets 
which are C# libraries built to be used as powershell commandlets. This enabled commandlets to get and send objects instead of pure text. Let's take our last two problems and solve them using powershell. 

First problem was that we had file containing file names and we wanted to replace ".txt" with ".text" and create them all. 

	gc ./files.txt | % {$_ -replace ".txt", ".text"} | % {touch $_}

Now it seems more complicated but take a few minutes to analyse this command further: first we read contents with gc and we get list of strings. With "%" we are executing some function for every element in given list and that element is passed to that function as "$_". This is like map functionality in functional programming languages. First function we use is function that takes one line and returns that line with replaced text. Second function takes line and calls touch on it. This can be put in one function instead of two, for instance:

	gc ./files.txt | % {touch ($_ -replace ".txt", ".text")}

For the secund problem we can do:

	gci | ? {$_.Name -match ".*\.txt"} | ? {$_.Mode -notmatch ".*r.."} | % {mv $_ "new-$_"}

As you can see, we can use "?" command for filtering, just provide function (inside brackets) which returns condition for filtering.

We can rewrite this command to include one filter with AND operator:

	gci | ? {$_.Name -match ".*\.txt" -and $_.Mode -notmatch ".*r.."} | % {mv $_ "new-$_"}


Additional interesting commandlets
==================================

We can read JSON files and output them as objects too: for instance:


	gc ./object.json                                                                                                                                               
	{
	        "Something": "value",
	        "list": [
	                {
	                        "name": "object1"
	                },
	                {
	                        "name": "object2"
	                },
	                {
	                        "name": "object3"
	                },
	        ]
	}

Now we can do this:

	gc object.json | ConvertFrom-Json

and we will get powershell representing our data. Similar thing we can do with CSV and XML files. Also, we can serialize objects back also:

	gci | ConvertTo-Json


For instance for CSV:

	gc data.csv | ConvertFrom-Csv

Also, there are commandlets for making HTTP requests, REST requests etc. You can also make your own commandlets from powershell or from C#. 

