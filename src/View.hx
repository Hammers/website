package;
import php.Lib; 

class View 
{
    public var context : Dynamic; 
    public function new()
    { 
		context = { };
    } 
    public function render()
    {  
		/*define a title page*/
		context.titlePage = "Ryan Hamlet";
		
      	  
      	/*load the main template and make a render of your page
      	coresponding to the context you created*/  
        var t = new templo.Loader("test.mtt");
		var r = t.execute(context);
		php.Lib.print(r);  
    }
    
}