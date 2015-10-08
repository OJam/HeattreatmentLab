package stages.hardness 
{
	import com.greensock.*;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author Yury Nikolaev
	 */
	public class Scale_C extends Scale_mc
	{
		public var bigArrow:BigArrow;
		public var smallArrow:SmallArrow;
		private var _this:Scale_C;
		public var scale:Scale_mc;
		
		public function Scale_C() 
		{
			_this = this;
			this.buttonMode = true;
			
			addEventListener(MouseEvent.CLICK, increase);
			
			this.width = 90;
			this.height = 90;
			
			scale = new Scale_mc();
			scale.rotation = - 32;
			addChild(scale);
			
			bigArrow = new BigArrow();
			bigArrow.x = 0;
			bigArrow.y = 0;			
			addChild(bigArrow);
			
			smallArrow = new SmallArrow();
			smallArrow.x = 40;
			smallArrow.y = -45;
			addChild(smallArrow);
		}
		
		private function increase(e:MouseEvent):void {
			parent.addChild(_this);
			TweenLite.to(_this, 1, { scaleX:0.9, scaleY:0.9, y:120 } );
			removeEventListener(MouseEvent.CLICK, increase);
			addEventListener(MouseEvent.CLICK, decrease);
		}
		
		private function decrease(e:MouseEvent):void{
			TweenLite.to(_this, 1, { scaleX:0.32, scaleY:0.32, y:52 } );
			removeEventListener(MouseEvent.CLICK, decrease);
			addEventListener(MouseEvent.CLICK, increase);
		}
	}

}