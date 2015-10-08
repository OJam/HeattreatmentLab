package stages 
{
	import flash.text.TextField;
	import flash.text.TextFormat;
	/**
	 * ...
	 * @author Yury Nikolaev
	 */
	public class InfoMsg_C extends InfoMsg_mc
	{
		public var isShowed:Boolean = false;
		private var txt:TextField;
		private var _this:InfoMsg_C;
		
		public function InfoMsg_C(_txt:String ) 
		{
			_this = this;
			
			txt = new TextField();
			txt.defaultTextFormat = new TextFormat("Arial", 24, 0xffffff, true);
			txt.autoSize = "center";
			txt.y = 18;
			txt.x = _this.width / 2 - txt.width / 2;
			txt.text = _txt;
			addChild(txt);
			
		}
		
	}

}