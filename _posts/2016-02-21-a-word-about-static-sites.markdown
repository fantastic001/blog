---
layout: post
title:  "A word about static sites"
date:   2016-02-21 02:09:00 +0100
categories: web
---

Recently I have had many discussions with web admins whether static or dynamic web site is better suiting some kinds of common
needs for businesses and organizations. This question is not well defined because it depends, but on what? 

It depends whether your page should just provide information or should provide and collect information, even more, some collecting of information can be outsourced to different services like services for comments. 

If your site is only presentation of your organization (only provides information to the user), it should be static. For example, if you
have a blog, it should be static because it only provides information. How will you maintain that site is up to you and you can use
web interface to do maintenance or can leave it to your console skills. 

Well, if blogs should be static, why platforms like WordPress or Drupal even exist? I don't know, maybe someone thought that 
UNIX simplicity model is a joke. It isn't. These platforms are unsecure and unstable. These platforms have so many layers that it makes them unstable and unsecure. There are many points where system can break or can be already broken. 

Static web pages are example how blogging can be done, without WordPress, without PHP or Python. I don't say they are bad for making web apps (OK, PHP is bad for this stuff) but I say that they are bad for making blog platforms or for making presentations on the web. 

In this post, I am going to explain how static sites can be used for blogs and organizations if they are providing information, it 
can be used if they want to collect information like comments. 

okay, first, you don't have to know every HTML tag or whole CSS syntax to build stuff up. You don't have to write entire thing from 
scratch. There are tools to do that. I am using [Jekyll](https://jekyllrb.com/) and it is simple tool to create static site. It is very customizable and it has 
a very nice documentation. It will take roughly an hour to get started with simple web page. Adding contents is very simple and you
can write in markdown. 

If you need comments every post, you can outsource this functionality to service like [disqus](https://disqus.com/).

There is even web application to do maintenance but I haven't tried any of them so I will not mention them. 

to measure traffic, you can outsource it to Google like [this](https://support.google.com/analytics/answer/1008080?hl=en).

I hope, after reading this post, you will at least try to make things simpler (by lowering number of layers). I expect to be criticism
to this way of doing things but it means we have topic to discuss. :) 

To end this post, I will summarize why static sites are better than dynamic if you do not have big goals in your had:

1. They are more secure 
2. They are easy to set up 
3. Hosting space is cheaper
4. They are lightweight
5. You can host them on your Github repository, for free.


