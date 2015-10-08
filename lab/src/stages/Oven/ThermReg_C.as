package stages.Oven 
{
	import com.greensock.TimelineLite;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.Timer;
	import stages.Stopwatch.Stopwatch_C;
		
	import com.greensock.*;
	/**
	 * ...
	 * @author Yury Nikolaev
	 */
	public class ThermReg_C extends ThermReg_mc
	{
		private var _this:ThermReg_C;
		private var currentTemp:TextField;
		private var progTemp:TextField;
		private var oven:Oven_C;
		
		private var upTemp:Sprite;
		private var downTemp:Sprite;
		private var prog:Sprite;
		
		private var progTmp:Number;
		public var isProget:Boolean = false;
		
		//таймер
		private var stopwatch:Stopwatch_C;
		
		public function ThermReg_C(_oven:Oven_C ) 
		{
			oven = _oven;
			_this = this;
			
			this.x = 30;
			this.y = 240;
			
			this.thermExit.buttonMode = true;
			this.thermExit.addEventListener(MouseEvent.CLICK, function():void { 
				parent.removeChild(_this); 
				//oven.setTemperature(currentTemp.text, progTemp.text);
			} );
			
			progTmp = oven.getProgTemperature();
			
			//текущая температура
			currentTemp = new TextField();
			currentTemp.defaultTextFormat = new TextFormat("Arial", 37, 0xff0000, true);
			currentTemp.alpha = 0.7;
			currentTemp.y = 30;
			currentTemp.x = 40;
			currentTemp.mouseEnabled = false;
			currentTemp.text = oven.getCurrentTemperature().toString();
			addChild(currentTemp);
			//программируемая температура
			progTemp = new TextField();
			progTemp.defaultTextFormat = new TextFormat("Arial", 34, 0x00ff00, true);
			progTemp.alpha = 0.7;
			progTemp.y = 88;
			progTemp.x = 40;
			progTemp.mouseEnabled = false;
			progTemp.text = oven.getProgTemperature().toString();
			addChild(progTemp);
			
			//увеличить температуру
			upTemp = new Sprite();
			upTemp.graphics.beginFill(0x00ff00,0.3);
			upTemp.graphics.drawRect(207, 28, 25, 25);
			upTemp.graphics.endFill();
			upTemp.buttonMode = true;
			upTemp.addEventListener(MouseEvent.CLICK, function():void { 
				progTmp += 10;
				progTemp.text = progTmp.toString();
				oven.setTemperature(oven.getCurrentTemperature(), progTemp.text);
			} );
			addChild(upTemp);
			
			//уменьшить температуру
			downTemp = new Sprite();
			downTemp.graphics.beginFill(0x00ff00,0.3);
			downTemp.graphics.drawRect(207, 60, 25, 25);
			downTemp.graphics.endFill();
			downTemp.buttonMode = true;
			downTemp.addEventListener(MouseEvent.CLICK, function():void { 
				progTmp -= 10;
				progTemp.text = progTmp.toString();
				oven.setTemperature(oven.getCurrentTemperature(), progTemp.text);
			} );
			addChild(downTemp);
			
			//кнопка прог
			prog = new Sprite();
			prog.graphics.beginFill(0x00ff00,0.3);
			prog.graphics.drawRect(207, 92, 25, 25);
			prog.graphics.endFill();
			prog.buttonMode = true;
			prog.addEventListener(MouseEvent.CLICK, progTemperature);
			addChild(prog);
			
			//таймер
			stopwatch = new Stopwatch_C();
			stopwatch.x = 30;
			stopwatch.y = 80;
			
		}
		
		public function setReady(k:Boolean):void {
			if(!k){	
				upTemp.alpha = 0;
				upTemp.mouseEnabled = false;
				
				downTemp.alpha = 0;
				downTemp.mouseEnabled = false;
				
				prog.alpha = 0;
				prog.mouseEnabled = false;
			}
			if(k){	
				upTemp.alpha = 1;
				upTemp.mouseEnabled = true;
				
				downTemp.alpha = 1;
				downTemp.mouseEnabled = true;
				
				prog.alpha = 1;
				prog.mouseEnabled = true;
			}
		}
		
		private function progTemperature(e:MouseEvent):void {
			if(oven.getCurrentTemperature() != progTmp){
				isProget = true;
				if(oven.loadedMaterials[0].getMark() == "20" && progTmp >= 900 && progTmp <= 920)
					heating();
				if(oven.loadedMaterials[0].getMark() == "45" && progTmp >= 850 && progTmp <= 870)
					heating();
				if(oven.loadedMaterials[0].getMark() == "У12" && progTmp >= 760 && progTmp <= 780)
					heating();
			}
		}
		
		//нагрев
		public function heating():void {
			parent.addChild(stopwatch);
			//var timer:Timer = new Timer(500, Math.round(progTmp / ((progTmp - oven.getCurrentTemperature()) * 0.08))); //переделать
			var curTmp:Number = oven.getCurrentTemperature();
			//блокируем кнопки на время нагрева
			upTemp.alpha = 0;
			upTemp.mouseEnabled = false;
			
			downTemp.alpha = 0;
			downTemp.mouseEnabled = false;
			
			prog.alpha = 0;
			prog.mouseEnabled = false;
			if(oven.loadedMaterials[0].getMark() == "20"){
				TweenLite.to(stopwatch.arr1, 5, { rotation:360 * 12 } );
				TweenLite.to(stopwatch.arr2, 5, { rotation:73 } );
			}
			if(oven.loadedMaterials[0].getMark() == "45"){
				TweenLite.to(stopwatch.arr1, 6, { rotation:360 * 18 } );
				TweenLite.to(stopwatch.arr2, 6, { rotation:107 } );
			}
			if(oven.loadedMaterials[0].getMark() == "У12"){
				TweenLite.to(stopwatch.arr1, 8, { rotation:360 * 25 } );
				TweenLite.to(stopwatch.arr2, 8, { rotation:149.5 } );
			}
			
			TweenLite.to(stopwatch, 5, { onComplete:function():void {
						parent.removeChild(stopwatch);	
						TweenLite.to(stopwatch.arr1, 0.1, { rotation:0 } );
						TweenLite.to(stopwatch.arr2, 0.1, { rotation:0 } );
						//ставим температуру в печи на дисплее
						currentTemp.text = progTmp.toString();
						oven.setTemperature(progTmp, progTmp.toString());
						for (var i:Number = 0; i < oven.loadedMaterials.length;i++ ){
							oven.loadedMaterials[i].gotoAndStop(2);//устанавливаем температуру материала
							oven.loadedMaterials[i].isHeated = true;
							oven.loadedMaterials[i].setTemperature(progTmp);
							//oven.forbidOpen(false);
						}
						oven.currentTemperature = progTmp; //ставим температуру в печи						
					}
				}
			);			
		}
		
		public function cooling():void{//остывание
			var timer:Timer = new Timer(3000, oven.getCurrentTemperature() * 0.01);
			var curTmp:Number = oven.getCurrentTemperature();//блокируем открытие пока греется печь
			timer.addEventListener(TimerEvent.TIMER, function():void {
				if (!oven.isOn) {	
					curTmp -= oven.getCurrentTemperature() * 0.01;
					
					currentTemp.text = curTmp.toFixed(1).toString();
					oven.setTemperature(curTmp, progTmp.toString());
					
					oven.currentTemperature = curTmp;
				}
			} );
			
			if(!oven.isOn)
				timer.start();
		}
	}

}