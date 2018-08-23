---
layout: post
title:  "Why some software projects fail? (and how to fix that)"
date:   2018-08-23 12:15:00 +0100
categories: software management opinion
---

after some time and many projects and books I have caught some reason why software projects fail. Let's face it: our world depends on software more than ever 
before on anything before.  However, software projects usually fail or they make it to the end of their development (version release) but they are broken in some way. 
Many software projects even do not make it to the final release and these which do, they are feature-short or have damaged performance. 

After reading "Rapid Development" by S. McConnell, you start to realize that many software projects share common mistakes made during development which make them to fail 
or to be broken when released. Many software projects do not make proper requirements analysis, architecture planning or risk management. Also, many of them face 
problems involved with people, poor teamwork and loss of motivation. In this article, I am going to list and describe some of these common issues but if you think that
these mistakes are worth further investigation, I suggest to read rapid development book by mentioned author above. 

Importance of planning 
------------------------

There is huge part before implementation which will help in software development and which will come back to you as boomerang if you miss this phase. 
I have worked on projects before where I did little or even no planning and where I started coding immediately. These projects were performance-poor or even did not 
make it to the end at all. If you plan to develop project in a team, development is impossible without further planning. 

Here I am going to divide planning process into four main phases: 

  * requirements analysis 
  * life cycle planning
  * architecture planning
  * design phase 

These phases are not disjoin and can overlap (and should). 

First of all you should ask yourself "what am I doing?" and write down answer on the paper (or into text editor). Requirements analysis consists of defining what the software 
should look like. In this phase you list all inputs and outputs of software, all features you want at near future, UI design. If you are developing GUI application then you
should draw interface and all user interactions. If you are building console applications, write down all command line arguments and their possible use cases. If you 
are building web app, design frontend side and interaction with user. If you are designing background service, define how it will behave and change state. You can 
draw state machine for your software if possible where you describe all possible states and their transitions. If you are developing software for customer, ask questions such
that customer needs to explain what he/she wants in detail. You can write use case scenario in form "Given X, when I do Y then Z" where X is state, Y is user action and Z is result 
and/or new state. In this process you also define performance requirements: how software fast needs to be? What is size of data processed. What is time required for one 
entry processing? This also means that you have to take into account user interaction. You should make use case such that user can do tasks fast (required time of interaction).

After requirements analysis, there is life cycle planning. In this phase you choose how to deliver product and what is process during development. For instance, the oldest 
one is waterfall where you go step by step in planning (from requirements analysis to architecture then to design and then to code / testing / QA) without overlapping.
This model is not used in many cases and is good if you have fully-specified software requirements. Examples of these are cases where you have to port software to 
another platform or to another language or technology. In that case you already have software and you know exactly what is needed. 

Another life cycle which is used for projects smaller than 500 lines of code (scripts and prototyping) is code and fix. Here you jump to coding without any planning. This
is enough for scripts and prototypes. The reason why I am mentioning this is to show that planning does not to be done for simple scripts but you have to draw clear red line
where border is. 

Method used today the most is evolutionary delivery. Where you do general requirements analysis and architectural analysis (and possibly some kind of code design) and 
then work in stages by versions. Every stage consists of further requirements,  design, coding and testing and finally delivery. After delivery, you take feedback from customer
and decide on next features (requirements) and repeat process. 

After life cycle analysis, based on selected model, we probably will do architectural analysis. In this step we define components of our software in general. Here 
we define do we have database, back-end, frontend? How do components interact with each other. Do we have some services running in background and how they communicate? 
Here we do not define our classes and UML diagrams. We just make black boxes and decide what parts do they communicate with. 

After architectural process, for each component, we do design process. Design depends on type of component. For database we will probably do entity relationship diagram. 
For back-end we will define classes, methods and API. For frontend we will define how we are planning to make interface to user and how to communicate with back-end. Here we choose 
technology stack which is going to be used and also make design compatible with technology stack. For instance, we do not worry about memory management if we are using Java 
but we do worry about it if we are using C and we have to take this into consideration. 
Also, in design phase we can provide unit tests for our API and even write some of them. 

After this, we are ready to start with construction. 

How important coding is?
---------------------------

After all above mentioned process, you probably realize that coding is very small part of whole process and typically is easy one. After you do proper planning, 
coding becomes just implementing functions inside components. You probably won't come to problems in this phase. 

Major risks 
--------------

Here is list of all major risks in most fo software projects. You should do risk management and make sure to control these risks. 

  * undermining motivation - treating people like children, not having empathy, acting as a bad-ass manager
  * weak personnel
  * not going well with bad apples in a team, not resolving issues in a team
  * not informing upper-management of trouble or behind-schedule things, making "can-do" schedules instead of carefully thinking
  * adding people to a late project
  * noisy, crowded offices
  * friction between developers and customers
  * unrealistic expectations
  * lack of effective project sponsorship
  * lack of user input
  * lack of stakeholder (marketing, sales, engineering, finance, ...) cooperation
  * wishful thinking - if we work hard enough and get lucky, we will succeed!
  * overly-optimistic schedules
  * insufficient risk management - not taking into account what can get wrong and making room to fix it
  * insufficient planning
  * abandonment of planning under pressure
  * too much time of fuzzy process like budgeting
  * jumping directly to coding without design and planning
  * inadequate design
  * shortening QA
  * omitting necessary tasks from estimates
  * planning to catch up later
  * code-like-hell programming
  * unnecessary requirements in the beginning
  * developer gold-plating - need to try brand new technologies, language features or implement non-required features
  * push me - pull me negotiation - make schedule longer but add additional features even though project is behind schedule
  * research-oriented development
  * silver-bullet syndrome - using technology without previously having experience with it
  * switching tools in the middle of a project
  * lack of automated source code control
