package;
import php.Lib; 

class Post 
{
    public var date : Date;
	public var dateString : String;
	public var url : String;
	public var title : String;
	public var body : String;
	
    public function new()
    { 
		date = Date.now();
		url = "";
		title = "";
		body = "";
		dateString = "";
    }
}