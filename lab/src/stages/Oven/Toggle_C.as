package stages.Oven 
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author Yury Nikolaev
	 */
	public class Toggle_C extends Toggle_mc
	{
		private var oven:Oven_C;
		private var maska:Sprite;
		
		public function Toggle_C(_oven:Oven_C) 
		{
			stop();
			oven = _oven;
			this.buttonMode = true;
			
			this.x = 205;
			this.y = 327;
			
			this.width = 11;
			this.height = 15;
			
			maska = new Sprite();
			maska.graphics.beginFill(0x00ff00, 0.3);
			maska.graphics.drawCircle(20, 20, 40);
			maska.graphics.endFill();
			addChild(maska);
			
			this.addEventListener(MouseEvent.CLICK, function():void { 
				if (currentFrame == 1 && !oven.getIsOpen()) {
				trace(oven.getIsOpen());	
					gotoAndStop(2);	
					oven.turnOn();
				}
				else if(currentFrame == 2){
					gotoAndStop(1);
					oven.turnOff();
				}
			} );
			
		}
		
		public function setUnActive():void{
			this.mouseEnabled = false;
			this.mouseChildren = false;
			maska.alpha = 0;
		}
		
		public function setActive():void{
			this.mouseEnabled = true;
			this.mouseChildren = true;
			maska.alpha = 1;
		}
	}

}