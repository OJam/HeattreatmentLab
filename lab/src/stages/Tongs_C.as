package stages 
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import stages.bucket.Bucket_C;
	import stages.material.Material_C;
	import flash.ui.Mouse;

	/**
	 * ...
	 * @author Yury Nikolaev
	 */
	public class Tongs_C extends Tongs_mc
	{
		private var startX:Number;
		private var startY:Number;
		private var oven:Oven_C;
		private var _this:Tongs_C;
		private var material:Material_C;
		public var isGrab:Boolean = false;
		private var waterBucket:Bucket_C;
		private var oilBucket:Bucket_C;
		
		public var isPicked:Boolean = false;
		
		private var material20:Vector.<Material_C>;
		
		public function Tongs_C(_x:Number, _y:Number, _oven:Oven_C, _waterBucket:Bucket_C, _oilBucket:Bucket_C, _mat20:Vector.<Material_C> ) 
		{
			stop();
			this.width = 300;
			this.height = 50;
			this.oven = _oven;
			_this = this;
			
			waterBucket = _waterBucket;
			oilBucket = _oilBucket;
			
			startX = _x;
			startY = _y;
			
			buttonMode = true;
			//addEventListener(MouseEvent.MOUSE_DOWN, downHandl);
			//addEventListener(MouseEvent.MOUSE_UP, upHandl);
			
			material20 = _mat20;
			
			this.addEventListener(Event.ENTER_FRAME, function():void { 
				var point:Point = localToGlobal( new Point(mouseX, mouseY));
				if(oven.ovenMask.hitTestObject(_this as DisplayObject)){
					if(oven.getCurrentTemperature() > 100){							
						if (!isGrab) {
							if(oven.loadedMaterials.length > 0){	
								material = oven.loadedMaterials.pop();
								if(oven.loadedMaterials.length == 0){
									oven.thermReg.setReady(true);
								}
								material.alpha = 0;
								material.x = material.startX;
								material.y = material.startY;
								isGrab = true;
								gotoAndStop(2);
							}
						}
					}
					//if (oven.loadedMaterials.length != 0 && material != null && oven.loadedMaterials[material.matNum-1] != null ) {
						//trace("show");
						//oven.loadedMaterials[material.matNum - 1].alpha = 1;
						//_this.gotoAndStop(1);
						//material = null;
					//}
				}
			} );
		}
		
		public function setMaterial(_material:Material_C):void{
			this.material = _material;
			
			if(material.getTemperature() > 100){
				_this.gotoAndStop(2);
			}
			if(material.getTemperature() < 100){
				_this.gotoAndStop(3);
			}
		}
				
		private function downHandl(e:MouseEvent):void{
			startDrag();
			mouseEnabled = false;
			mouseChildren = false;
			var point:Point = globalToLocal(globalToLocal(new Point(mouseX, mouseY)));
			
			trace(this.x);
			trace(point.x);
			
			this.x = point.x;
			this.y = point.y;
			
			//Mouse.hide();
			
			parent.addChild(this);
			parent.addEventListener(MouseEvent.MOUSE_UP, upHandl);
		}
		
		private function upHandl(e:MouseEvent):void {
		
			var point:Point = new Point(stage.mouseX, stage.mouseY);
			trace(waterBucket.x);
			trace(point.x);
			if(waterBucket.hitTestPoint(point.x, point.y)){
				this.x = startX;
				this.y = startY;
			}
			mouseEnabled = true;
			mouseChildren = true;
			this.x = startX;
			this.y = startY;
		}
		
		public function dropMaterial():void{
			isGrab = false;
			if(material){
				material.alpha = 1;
				if(material.getTypeOfCooling() != "air")
					material.gotoAndStop(1);
				material.setTemperature(20);
			}
		}
		
		public function getMaterial():Material_C{
			return material;
		}
	}

}