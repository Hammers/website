package;
import php.Lib;
import php.Web;
import templo.Loader;
import sys.FileSystem;

class Index {
	static function main()
      		{
      			new Index();
      		}
      		public function new()
      		{ 
    // set some parameters
	templo.Loader.BASE_DIR = "tpl/";
	templo.Loader.TMP_DIR = "tmp/";
	templo.Loader.MACROS = null; // no macro file
	var params = Web.getParams(); 
	// the template context which will be available 
	var context = { 
		titlePage  		: "Ryan Hamlet",
		templatePage	: (params.exists('p')?((FileSystem.exists(Loader.BASE_DIR+params.get('p')+'.mtt'))?params.get('p'):'page_not_found'):'home')+'.mtt',
	};

	// loads template 
	var t = new templo.Loader("test.mtt");
	var r = t.execute(context);
	php.Lib.print(r);	
	}
}