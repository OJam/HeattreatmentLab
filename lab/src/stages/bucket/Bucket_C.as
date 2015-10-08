package stages.bucket 
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import stages.InfoMsg_C;
	/**
	 * ...
	 * @author Yury Nikolaev
	 */
	public class Bucket_C extends InWater_mc
	{
		public var count:Number = 0;
		public var isAllow:Boolean = false;
		private var infMsg:InfoMsg_C;
		
		public function Bucket_C(_inf:String) 
		{
			infMsg = new InfoMsg_C(_inf);
			infMsg.y = 270;
			infMsg.x = 130;
			infMsg.width = 900;
			infMsg.height = 450;
			//addChild(infMsg);
			
			addEventListener(MouseEvent.MOUSE_OVER, function():void { addChild(infMsg); } );
			addEventListener(MouseEvent.MOUSE_OUT, function():void { removeChild(infMsg); } );
			
			this.width = 150;
			this.height = 300;
			this.gotoAndStop(1);						
		}
		
		public function playAnimation(e:Event):void {
			//play();
			this.mouseEnabled = false;
			this.mouseChildren = false;
			count++;
			if(count * 2 == totalFrames * 2 ){
				removeEventListener(Event.ENTER_FRAME, playAnimation);
				stop();
				var timer:Timer = new Timer(500, 1);
				timer.addEventListener(TimerEvent.TIMER_COMPLETE, function():void { 
					gotoAndStop(1);
					this.mouseEnabled = true;
					this.mouseChildren = true;
				} );
				timer.start();
				//this.gotoAndStop(1);
			}
			if(currentFrame+1 == totalFrames) {
				//trace(currentFrame);
				count++;
				gotoAndPlay(2);				
			}
		}
		
		public function planmtm():void{
			if (isAllow) {				
				count = 0;
				addEventListener(Event.ENTER_FRAME, playAnimation);
				play();		
			}
		}
	}

}