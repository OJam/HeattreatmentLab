package stages.Oven 
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author Yury Nikolaev
	 */
	public class Handle_C extends Handle_mc
	{
		private var oven:Oven_C;
		private var maska:Sprite;
		private var _this:Handle_C;
		
		public function Handle_C() 
		{
			_this = this;
			
			this.x = 300;
			this.y = 129;
			
			maska = new Sprite();
			maska.graphics.beginFill(0x00ff00);
			maska.graphics.drawRect(0, 0, _this.width, _this.height);
			maska.alpha = 0.3;
			maska.graphics.endFill();
			addChild(maska);
		}
		
		public function init(_oven:Oven_C):void{
			this.oven = _oven;
			this.buttonMode = true;
			
			addEventListener(MouseEvent.CLICK, openOven);
		}
		
		public function setUnActive():void{
			this.maska.alpha = 0;
			this.mouseEnabled = false;
			this.mouseChildren = false;
		}
		
		public function setActive():void{
			this.maska.alpha = 0.3;
			this.mouseEnabled = true;
			this.mouseChildren = true;
		}
		
		private function openOven(e:MouseEvent):void{
			oven.open();
		}
	}

}