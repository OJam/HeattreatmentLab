package stages.material 
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import stages.Caliper_C;
	import stages.hardness.HardnessTester_C;
	import stages.InfoMsg_C;
	import stages.Otpusk.OvenOtpusk_C;
	/**
	 * ...
	 * @author Yury Nikolaev
	 */
	public class Material_C extends Material_mc
	{
		private var temperature:Number = 20;
		public var startX:Number;
		public var startY:Number;
		
		public var startX2:Number;
		public var startY2:Number;
		
		private var oven:Oven_C;
		private var _this:Material_C;
		private var mark:String;
		private var diam:Number;
		private var matMask:Sprite;
		
		//инфо
		private var infoMsg:InfoMsg_C;
		public var matNum:Number;
		
		//переменные для загрузки в печь
		public var isLoad:Boolean = false;
		public var loadIndex:int = -5;	
		private var typeOfCooling:String;
		
		//охлаждение
		public var isCooled:Boolean = false;
		
		//указываем какая сейчас стадия
		private var currentStage:Number = 0;
		public var isHeated:Boolean = false;
		//измеритель твердости
		private var hardnessTester:HardnessTester_C;
		public var isHardTest1:Boolean = false;
		//печи для отпуска
		private var oven1:OvenOtpusk_C;
		private var oven2:OvenOtpusk_C;
		private var oven3:OvenOtpusk_C;
		private var isLoadOtpusk:Boolean = false;
		public var isOtpusk:Boolean = false;
		
		private var caliper:Caliper_C;
		
		public function Material_C(_x:Number, _y:Number, _oven:Oven_C, _mark:String, _num:Number, _caliper:Caliper_C,typeOfCooling:String) 
		{
			stop();
			
			caliper = _caliper;
			matNum = _num+1;
			_this = this;
			this.width = 15;
			this.height = 23;
			mark = _mark;
			startX = _x;
			startY = _y;
			oven = _oven;
			
			this.buttonMode = true;		
			
			//this.addEventListener(MouseEvent.MOUSE_DOWN, downHandler);
			//this.addEventListener(MouseEvent.MOUSE_UP, upHandler);
			
			matMask = new Sprite();
			matMask.graphics.beginFill(0x00ff00,0.3);
			matMask.graphics.drawRect(0, 0, 36, 57);
			matMask.graphics.endFill();
			addChild(matMask);
			
			infoMsg = new InfoMsg_C("Сталь " + _mark + ", образец № " + (_num+1).toString() + " (" + typeOfCooling + ")" );
			infoMsg.mouseEnabled = false;
			infoMsg.mouseChildren = false;
			infoMsg.height = 250;
			infoMsg.width = 1100;
			infoMsg.x = - infoMsg.width / 2 + 10;
			infoMsg.y = - infoMsg.height;
			this.addEventListener(MouseEvent.MOUSE_OVER, function():void { 
				addChild(infoMsg);
				infoMsg.mouseEnabled = false;
				infoMsg.mouseChildren = false;
				matMask.alpha = 0;
			} );
			this.addEventListener(MouseEvent.MOUSE_OUT, function():void { 
				removeChild(infoMsg);
				matMask.alpha = 1;
			} );
		}
		
		public function setActive():void{
			matMask.alpha = 1;
			this.mouseEnabled = true;
			this.mouseChildren = true;
		}
		
		public function setUnActive():void{
			matMask.alpha = 0;
			this.mouseEnabled = false;
			this.mouseChildren = false;
		}
		
		
		public function setCurrentStage(_currStage:Number):void{
			this.currentStage = _currStage;
		}
		
		public function setDiam(_diam:Number):void{
			diam = _diam;
		}
		public function getDiam():Number{
			return diam;
		}
		
		public function getMark():String{
			return mark;
		}
				
		//private function downHandler(e:MouseEvent):void {
			//infoMsg.alpha = 0;
			//if(temperature < 100){
				//parent.addChild(this);	
				//startDrag();
			//}
		//}
		//
		//private function upHandler(e:MouseEvent):void {
			//stopDrag();
			//infoMsg.alpha = 1;
			//
			//var point:Point = localToGlobal(new Point(mouseX, mouseY));
			//
			//if (oven.getMask().hitTestPoint(point.x, point.y) && !isHeated && !isLoad) {
					//
				//if(oven.loadedMaterials.length == 0){
					//isLoad = true;
					//if (loadIndex == -5){
						//loadIndex = oven.loadedMaterials.length;
						//trace(loadIndex);
					//}
					//oven.loadedMaterials.splice(loadIndex, 0, _this);
					//
					//this.x = 150 + 40 * (loadIndex); 
					//this.y = 425;
				//}					
				//else if(oven.loadedMaterials[0].getMark() == _this.getMark()){
					//isLoad = true;
					//if (loadIndex == -5){
						//loadIndex = oven.loadedMaterials.length;
					//}
					//oven.loadedMaterials.splice(loadIndex, 0, _this);
					//if(loadIndex < 3){
						//this.x = 150 + 40 * (loadIndex); 
						//this.y = 425;
					//}
					//else{
						//this.x = 170 + 40 * (loadIndex-3); 
						//this.y = 438;
					//}						
					//
					//if((oven.loadedMaterials.length == 3 && (oven.loadedMaterials[0].getMark() == "20" || oven.loadedMaterials[0].getMark() == "45")) || (oven.loadedMaterials.length == 5 && (oven.loadedMaterials[0].getMark() == "У12"))){//добавить для 5 материалов
						//oven.isLoad = true;
						//trace(isLoad);
					//}
				//}
				//else if(currentStage == 1){
					//if (isLoad) {
						//oven.loadedMaterials.pop();	
					//}
					//isLoad = false;
					//trace(oven.loadedMaterials.length);
					//
					//this.x = startX;
					//this.y = startY;
				//}
			//}		
			//else if(currentStage == 1 && caliper.hitTestPoint(point.x, point.y)){
				//caliper.setReady(this);
			//}
			//else if(currentStage == 1 && this.temperature < 100){
				//if (isLoad) {
					//oven.loadedMaterials.pop();	
					////oven.loadedMaterials.splice(loadIndex, 1);
				//}
				//isLoad = false;
				////trace(oven.loadedMaterials[0].getMark());
				//
				//this.x = startX;
				//this.y = startY;
			//}
			//else if(hardnessTester.hitTestPoint(point.x,point.y) && (currentStage == 2 || currentStage == 4) && !hardnessTester.isReady){
				//hardnessTester.setReadyToMeasure(_this);
			//} 
			//else if(currentStage == 2 || currentStage == 4){				
				//this.x = startX2;
				//this.y = startY2;
			//}
			//else if(oven1.getMask().hitTestPoint(point.x, point.y) && matNum == 1){				
				//oven1.setMaterial(this);
			//}
			//else if(oven2.getMask().hitTestPoint(point.x, point.y) && matNum == 2){				
				//oven2.setMaterial(this);
			//}
			//else if(oven3.getMask().hitTestPoint(point.x, point.y) && matNum == 3){				
				//oven3.setMaterial(this);
			//}
			//else if(currentStage == 3){				
				//this.x = startX;
				//this.y = startY;
			//}
		//}
		
		public function setHardnessTester(_tester:HardnessTester_C):void{
			this.hardnessTester = _tester;
		}
		public function setSize(stageNumber:Number):void{
			if (stageNumber == 1 ) {
				_this.width = 15;
				_this.height = 23;
			}
			if	(stageNumber == 2) {
				if (mark == "20") {
					this.width = 20;
					this.height = 30;
				}
				else{
					this.width = 25;
					this.height = 30;
				}
			}
		}
		
		public function setTemperature(_tmp:Number):void{
			this.temperature = _tmp;
		}
		public function getTemperature():Number{
			return temperature;
		}
		
		public function setTypeOfCooling(type:String):void{
			this.typeOfCooling = type;
		}
		public function getTypeOfCooling():String{
			return typeOfCooling;
		}
		
		public function gotoStartPosotion(_stageNumber:Number):void{
			switch (_stageNumber){
				case 1:
					this.x = startX;
					this.y = startY;
					break;
				case 2:
					this.x = startX2;
					this.y = startY2;
					break;
			}
			
		}
		//работа с печами для отпуска
		public function setOvenOtpusk(_ov1:OvenOtpusk_C,_ov2:OvenOtpusk_C,_ov3:OvenOtpusk_C):void{
			oven1 = _ov1;
			oven2 = _ov2;
			oven3 = _ov3;
		}
		public function setIsLoadOtpusk(isLoad:Boolean):void{
			isLoadOtpusk = isLoad;
		}
		public function getIsLoadOtpusk():Boolean{
			return isLoadOtpusk;
		}
	}

}