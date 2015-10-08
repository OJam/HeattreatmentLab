package stages 
{
	import com.adobe.air.crypto.EncryptionKeyGenerator;
	import com.greensock.TweenLite;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import stages.material.Material_C;
	/**
	 * ...
	 * @author Yury Nikolaev
	 */
	public class Caliper_C extends Calipers
	{
		private var bg:Sprite;
		private var _this:Caliper_C;
		private var allShowed:Boolean = false;
		private var materal:Material_C;
		private var startX:Number;
		private var startY:Number;
		
		public function Caliper_C() 
		{
					
			rotation = 30;
			mat15.alpha = 0;
			mat20.alpha = 0;
			back.alpha = 0;
			back.addEventListener(MouseEvent.CLICK, function():void { setNotReady(); } );
			back.mouseEnabled = false;
			back.mouseChildren = false;
			moveCalipers_mc.mouseEnabled = false;
			moveCalipers_mc.mouseChildren = false;
			
			
		}
		
		public function setStartPosition(_x:Number):void{
			startX = _x;
		}
		
		public function setReady(_mat:Material_C):void{
			TweenLite.to(this, 2, { rotation:0, scaleX:3, scaleY:3, x:100 } );
			moveCalipers_mc.buttonMode = true;
			moveCalipers_mc.mouseEnabled = true;
			moveCalipers_mc.mouseChildren = true;
			moveCalipers_mc.x = 30;
			materal = _mat;
			materal.x = materal.startX;
			materal.y = materal.startY;
			materal.alpha = 0;
			materal.mouseEnabled = false;
			materal.mouseChildren = false;
			back.alpha = 1;
			back.mouseEnabled = true;
			back.mouseChildren = true;
			back.buttonMode = true;
			if(materal.getMark() == "20"){
				mat15.alpha = 1;
				var bounds:Rectangle = new Rectangle(21, moveCalipers_mc.y, 100, 0);
			}
			else{
				mat20.alpha = 1;
				var bounds:Rectangle = new Rectangle(25, moveCalipers_mc.y, 100, 0);
			}
			
			moveCalipers_mc.addEventListener(MouseEvent.MOUSE_DOWN, function():void { moveCalipers_mc.startDrag(false, bounds); } );
			moveCalipers_mc.addEventListener(MouseEvent.MOUSE_UP, function():void { trace(moveCalipers_mc.x); } );
		}
		
		public function setNotReady():void{
			TweenLite.to(this, 2, { rotation:30, scaleX:1, scaleY:1, x:startX } );
			moveCalipers_mc.buttonMode = false;
			moveCalipers_mc.mouseEnabled = false;
			moveCalipers_mc.mouseChildren = false;
			
			materal.alpha = 1;
			materal.mouseEnabled = true;
			materal.mouseChildren = true;
			materal = null;
			
			mat15.alpha = 0;
			mat20.alpha = 0;
			
			back.alpha = 0;
			back.mouseEnabled = false;
			back.mouseChildren = false;
		}
	}

}