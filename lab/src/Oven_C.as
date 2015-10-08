package 
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import stages.material.Material_C;
	import stages.Oven.Arrow_C;
	import stages.Oven.Handle_C;
	import stages.Oven.ThermReg_C;
	import stages.Oven.Toggle_C;
	import com.greensock.TweenLite;
	import stages.Stopwatch.Stopwatch_C;
	/**
	 * ...
	 * @author Yury Nikolaev
	 */
	public class Oven_C extends Oven_mc
	{
		public var handle:Handle_C;
		public var closeHandle:Sprite;
		private var isOpen:Boolean = false;//открыта ли печь
		public var currentTemperature:Number = 20;//температура в печи
		private var progTemperature:Number = 850;// программируемая температура в печи
		private var thermBut:Sprite;
		public var thermReg:ThermReg_C;
		private var currentTemp:TextField;
		private var progTemp:TextField;
		public var ovenMask:Sprite;
		
		private var toggle:Toggle_C;
		private var arrow:Arrow_C;
		
		public var isLoad:Boolean = false;//загружен ли материал в печь
		public var loadedMaterials:Vector.<Material_C> = new Vector.<Material_C>;
		
		
		//таймер
		private var stopwatch:Stopwatch_C;
		
		public var isOn:Boolean = false;//включена ли печь
		
		public function Oven_C() 
		{
			stop();
			
			//добавляем ручку для открытия
			handle = new Handle_C();
			handle.init(this);			
			addChild(handle);			
			
			//ручка для закрытия
			closeHandle = new Sprite();
			closeHandle.graphics.beginFill(0x00ff00);
			closeHandle.graphics.drawCircle(35, 165, 10);
			closeHandle.addEventListener(MouseEvent.CLICK, close);
			closeHandle.alpha = 0.3;
			closeHandle.buttonMode = true;
			
			//маска в печи
			ovenMask = new Sprite();
			ovenMask.graphics.beginFill(0x00ff00);
			ovenMask.graphics.drawRoundRect(125, 95, 135, 80, 20);
			ovenMask.alpha = 0.3;
			ovenMask.buttonMode = true;
			//addChild(ovenMask);
			
			//поле текущей температуры
			currentTemp = new TextField();
			currentTemp.defaultTextFormat = new TextFormat("Arial", 9, 0xff0000, true);
			currentTemp.text = currentTemperature.toString();
			currentTemp.x = 103;
			currentTemp.y = 296;
			currentTemp.alpha = 0.8;
			currentTemp.mouseEnabled = false;	
			currentTemp.alpha = 0;
			addChild(currentTemp);
			
			//поле текущей температуры
			progTemp = new TextField();
			progTemp.defaultTextFormat = new TextFormat("Arial", 8, 0x00ff00, true);
			progTemp.text = progTemperature.toString();
			progTemp.x = 103;
			progTemp.y = 309;
			progTemp.alpha = 0.8;
			progTemp.mouseEnabled = false;
			progTemp.alpha = 0;
			addChild(progTemp);
			
			//вызов регулятора температуры
			thermBut = new Sprite();
			thermBut.graphics.beginFill(0x00ff00);
			thermBut.graphics.drawRoundRect(90, 280, 75, 55,20,20);
			thermBut.alpha = 0.3;
			thermBut.graphics.endFill();
			thermBut.buttonMode = true;
			thermBut.addEventListener(MouseEvent.MOUSE_OVER, function():void { thermBut.alpha = 0; } );
			thermBut.addEventListener(MouseEvent.MOUSE_OUT, function():void { thermBut.alpha = 0.3; } );
			thermBut.addEventListener(MouseEvent.CLICK, showThermRegulator);
			//addChild(thermBut);
			
			//регулятор температуры
			thermReg = new ThermReg_C(this);
			
			//тумблер включения
			toggle = new Toggle_C(this);
			addChild(toggle);
			
			arrow = new Arrow_C();
			addChild(arrow);
			
			
			
			//устанавливаем начальное состояние печи
			startState();
		}
		
		private function startState():void{
			forbidOpen(false);
			toggle.setUnActive();
		}
		
		//открываем печь
		public function open():void {
			this.isOpen = true;
			if(currentTemperature < 100)
				this.gotoAndStop(2);
			else
				this.gotoAndStop(3);
			
			addChild(closeHandle);
			addChild(ovenMask);
			removeChild(handle);
			toggle.setUnActive();
			
			for (var i:Number = 0; i < loadedMaterials.length; i++ ){
				parent.addChild(loadedMaterials[i]);
			}
		}	
		//закрываем печь
		private function close(e:MouseEvent):void{
			this.isOpen = false;			
			this.gotoAndStop(1);
			
			addChild(handle);
			removeChild(ovenMask);
			removeChild(closeHandle);
			
			for (var i:Number = 0; i < loadedMaterials.length; i++ ){
				parent.removeChild(loadedMaterials[i]);
			}
			
			if(isLoad){
				toggle.setActive();
			}
			else{
				toggle.setUnActive();
			}
		}
		//открыта ли печь, возвращаем состояние
		public function getIsOpen():Boolean{
			return isOpen;
		}
		public function getCurrentTemperature():Number{
			return currentTemperature;
		}
		public function getProgTemperature():Number{
			return progTemperature;
		}
		public function setTemperature(_currentTmp:Number, _progTmp:String):void {
			
			this.currentTemp.text = _currentTmp.toFixed(1).toString();
			this.progTemp.text = _progTmp;
			//currentTemperature = _currentTmp;
		}
		public function turnOn():void{//включаем печь
			//addChild(progTemp);
			TweenLite.to(progTemp, 0.3, { alpha:0.5 } );
			//addChild(currentTemp);
			TweenLite.to(currentTemp, 0.3, { alpha:0.5 } );
			addChild(thermBut);
			arrow.setRotation( -70);
			
			isOn = true;
			handle.setUnActive();
			//if (thermReg.isProget) {
				//thermReg.heating();
			//}
		}
		public function turnOff():void{//выключаем печь
			//removeChild(progTemp);
			TweenLite.to(progTemp, 0.3, { alpha:0 } );
			//removeChild(currentTemp);
			TweenLite.to(currentTemp, 0.3, { alpha:0 } );
			removeChild(thermBut);
			arrow.setRotation( -90);
			
			isOn = false;
			handle.setActive();
			toggle.setUnActive();
			//thermReg.cooling();
		}
		public function getMask():Sprite{
			return ovenMask;
		}
		
		private function showThermRegulator(e:MouseEvent):void{
			addChild(thermReg);
		}
		
		
		
		public function forbidOpen(t:Boolean):void{
			if(t){
				handle.setUnActive();
				toggle.setUnActive();
				//toggle.mouseEnabled = false;
			}
			else{
				handle.setActive();
				toggle.setActive();
				//toggle.mouseEnabled = true;
			}
		}
	}

}