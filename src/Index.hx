package;
import php.Lib;
import php.Web;
import templo.Loader;
import sys.FileSystem;
import sys.io.File;
import haxe.web.Dispatch;

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
		Dispatch.run(Web.getURI(), Web.getParams(), new DispatchAPI());
	}
}