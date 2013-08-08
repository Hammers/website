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
	
	function doIndex(d : Dispatch)
	{
		/*Create a new View , set the context of the page you want to display,
		and make a render of the view*/
      	var view = new View();
		view.context.posts = getPosts();
      	/*if the template that we want to request exists, initialize the context variable "templatePage" with the template name, 
      	if not, display the template coresponding to the "page_not_found"*/
      	view.context.templatePage = "blog.mtt";
      		    
      	/*Make a render of the current page*/
      	view.render(); 
	}
	
	function doPost(year : String, month : String, name : String, d : Dispatch)
	{
		if (year == "" || month == "" || name == "") doDefault(d);
		else
		{
			var post = [findPost(year, month, name)];
			var view = new View();
			view.context.posts = post;
			/*if the template that we want to request exists, initialize the context variable "templatePage" with the template name, 
			if not, display the template coresponding to the "page_not_found"*/
			view.context.templatePage = "blog.mtt";
					
			/*Make a render of the current page*/
			view.render();
		}
	}
	
	function doProjects(d : Dispatch)
	{
		/*Create a new View , set the context of the page you want to display,
		and make a render of the view*/
      	var view = new View();
      	/*if the template that we want to request exists, initialize the context variable "templatePage" with the template name, 
      	if not, display the template coresponding to the "page_not_found"*/
      	view.context.templatePage = "projects.mtt";
      		    
      	/*Make a render of the current page*/
      	view.render(); 
	}
	
	function doDefault(d : Dispatch) 
	{
		if (d.parts[0] == "") doIndex(d);
		else
		{
			var view = new View();
			/*if the template that we want to request exists, initialize the context variable "templatePage" with the template name, 
			if not, display the template coresponding to the "page_not_found"*/
			view.context.templatePage = "page_not_found.mtt";
					
			/*Make a render of the current page*/
			view.render();
		}
	}
	
	function getPostNames() : Array<String> 
	{
		var posts = FileSystem.readDirectory("posts");
		posts.sort(function(a,b) return Reflect.compare(b.toLowerCase(),a.toLowerCase()) );
		return posts;
	}
	
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
}