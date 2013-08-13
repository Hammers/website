package;
import php.Lib;
import php.Web;
import templo.Loader;
import sys.FileSystem;
import sys.io.File;
import haxe.web.Dispatch;

class DispatchAPI
{
	public function new() {
    }
	
	//Purpose: 	Called when "/index" is requested
	//Takes:	d - This dispatch variable contains the remainder of the URI parts after index.
	function doIndex(d : Dispatch)
	{
		//This gets the php GET params
		var params = Web.getParams();
      	var view = new View();
		//If a specific page has been requested use that, othewise show the first.
		view.context.page = params.exists('page')?params.get('page'):1;
		view.context.posts = getPosts(view.context.page);
		view.context.pagination = hasPagination(view.context.page);
      	view.context.templatePage = "blog.mtt";
      	view.render(); 
	}
	
	//Purpose: 	Called when "/year/month/postName" is requested
	//Takes:	year - The string matched to the year section of the URI
	//			month - The string matched to the month section of the URI
	//			name - The string matched to the year section of the URI
	//			d - This dispatch variable contains the remainder of the URI parts after index.
	function doPost(year : String, month : String, name : String, d : Dispatch)
	{
		if (year == "" || month == "" || name == "") doDefault(d);
		else
		{
			var post = [findPost(year, month, name)];
			var view = new View();
			view.context.posts = post;
			view.context.templatePage = "single_post.mtt";
			view.render();
		}
	}
	
	//Purpose: 	Called when "/projects" is requested
	//Takes:	d - This dispatch variable contains the remainder of the URI parts after index.
	function doProjects(d : Dispatch)
	{
      	var view = new View();
      	view.context.templatePage = "projects.mtt";
      	view.render(); 
	}
	
	//Purpose: 	Called when "/projects" is requested
	//Takes:	d - This dispatch variable contains the remainder of the URI parts after index.
	function doAbout(d : Dispatch)
	{
      	var view = new View();
      	view.context.templatePage = "about.mtt";
      	view.render(); 
	}
	
	//Purpose: 	Called when "/" or "/XXX" is requested where XXX isn't matched to anything above.
	//Takes:	d - This dispatch variable contains the remainder of the URI parts after index.
	function doDefault(d : Dispatch) 
	{
		//If the URI is empty then just display the front page.
		if (d.parts[0] == "") doIndex(d);
		else
		{
			//Otherwise display a 404 page
			var view = new View();
			view.context.templatePage = "page_not_found.mtt";
			view.render();
		}
	}
	
	//Purpose: 	Get the names of all posts.
	//Returns:	An array of all post names.
	function getPostNames() : Array<String> 
	{
		var posts = FileSystem.readDirectory("posts");
		posts.sort(function(a,b) return Reflect.compare(b.toLowerCase(),a.toLowerCase()) );
		return posts;
	}
	
	//Purpose: 	Get a given number of posts.
	//Takes:	page - The page of posts we're requesting
	//			perPage - The number of posts to display
	//Returns:	An array of all posts in the given section.
	function getPosts(page = 1, perPage = 5) : Array<Post>
	{
		var posts = getPostNames();
		var pageStart = (page-1) * perPage;
		posts = posts.slice(pageStart, pageStart + perPage);
		var tmp = new Array();
		for (postName in posts)
		{
			var post = new Post();
			var arr = postName.split("_");
			post.date = Date.fromString(arr[0]);
			post.dateString = DateTools.format(post.date, "%b %d");
			post.url = "post/"+DateTools.format(post.date, "%Y") + "/" + DateTools.format(post.date, "%m") + "/" + StringTools.replace(arr[1], ".md", "");
			var content = Markdown.markdownToHtml(File.getContent("posts/" + postName));
			arr = content.split("</h1>");
			post.title = StringTools.replace(arr[0], "<h1>", "");
			post.body = arr[1];
			
			tmp.push(post);
		}
		return tmp;
	}
	
	//Purpose: 	Find a specific post from it's date and title.
	//Takes:	year - The year of the post from the URI
	//			month - The month of the post from the URI
	//			name - The name of the post from the URI
	//Returns:	The given post if it's found or null if it doesn't exist
	function findPost(year:String, month:String, name:String) : Post
	{
		var posts = getPostNames();
		var index = 0;
		for (post in posts)
		{
			if (post.indexOf(year + "-" + month) >= 0 && post.indexOf(name) >= 0)
			{
				var arr = getPosts(index + 1, 1);
				return arr[0];
			}
			index++;
		}
		return null;
	}
	
	//Purpose: 	Decide if the given page should show page/forward backward buttons.
	//Takes:	page - The page number
	//Returns:	A Dyaninc containing a bool for the "next" and "prev" buttons
	function hasPagination(page = 1)
	{
		var total = getPostNames().length;
		var arr:Dynamic = {prev:page > 1, next:total > page * 5};
		return arr;
	}
}