# Bugs Dispatched

Right, after a bit of [head scratching](http://stackoverflow.com/questions/18113514/unable-to-get-default-working-with-haxe-web-dispatch/) and a lot of wrangling with .htaccess files,
I finally got Dispatch working. Dispatch is basically a light php framework (well in this case a [haxe library](http://haxe.org/manual/dispatch)) which allows the use of
urls such as foo.com/abc/def to be used and have abc and def be used to call different functions or be passed as parameters to functions and serve up different parts of the site.
You can click on the title of this post for an eaxmple of one such URL.

So yeah, I found it a bit of hassle to set up, but this is probably more to do with my unfamiliarity with web development
rather than anything else. The actual code I had to write to get it working is lovely and small, and the library is incredibly flexible. I would highly recommend
it to anyone looking to do some fancy URL redirection and page serving. Check out [this blog post](http://jasononeil.com.au/2013/05/29/creating-complex-url-routing-schemes-with-haxe-web-dispatch/)
for some nice examples of how powerful it is.

Now the only thing I really have left to get working is the pagination of the blog posts so you can actually see past 5 posts and possibly setting up an rss feed. Oh and writing the rest of the content!