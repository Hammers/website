package;
import php.Lib;
import php.Web;
import templo.Loader;
import sys.FileSystem;
import sys.io.File;


class Index {
	static function main()
    {
		new Index();
    }
    
	public function new()
    { 
		// set some parameters
		templo.Loader.OPTIMIZED = true;
		templo.Loader.BASE_DIR = "tpl/";
		templo.Loader.TMP_DIR = "tmp/";
		templo.Loader.MACROS = null; // no macro file
		var params = Web.getParams(); 
		/*Create a new View , set the context of the page you want to display,
		and make a render of the view*/
      	var view = new View();
		view.context.posts = getPosts();
      	/*if the template that we want to request exists, initialize the context variable "templatePage" with the template name, 
      	if not, display the template coresponding to the "page_not_found"*/
      	view.context.templatePage = (params.exists('p')?((FileSystem.exists(Loader.BASE_DIR + params.get('p') + '.mtt'))?params.get('p'):'page_not_found'):'blog') + '.mtt';
      	view.context.pageName = (params.exists('p')?((FileSystem.exists(Loader.BASE_DIR + params.get('p') + '.mtt'))?params.get('p'):'page_not_found'):'blog');
      		    
      	/*Make a render of the current page*/
      	view.render();  
	}
	
	function getPostNames() : Array<String> 
	{
		var posts = FileSystem.readDirectory("posts");
		posts.reverse();
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
			post.url = "?p=blog&y="+DateTools.format(post.date, "%Y") + "&m=" + DateTools.format(post.date, "%m") + "&n=" + StringTools.replace(arr[1], ".md", "");
			var content = File.getContent("posts/"+postName);
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