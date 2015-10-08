package stages.hardness 
{
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import Interface.PhazesInfo;
	import stages.hardness.Scale_C;
	import stages.material.Material_C;
	
	import com.greensock.TweenLite;
	/**
	 * ...
	 * @author Yury Nikolaev
	 */
	 
	public class LiftPlace_C extends LiftPlace_mc
	{
		private var liftBut:Sprite;
		private var moveBut:Sprite;
		
		private var diam:Number;
		private var _this:LiftPlace_C;
		
		private var stopFrame:Number;
		private var materialMask:Sprite;
		private var scale:Scale_C;
		private var material:Material_C;
		private var tester:HardnessTester_C;
		
		private var phazesInfo:PhazesInfo;
						
		public function LiftPlace_C(_scale:Scale_C, _tester:HardnessTester_C,  _phazesButton:PhazesInfo) 
		{			
			stop();
			
			phazesInfo = _phazesButton;
			
			this.width = 210;
			this.height = 350;
			
			liftBut = new Sprite();
			liftBut.graphics.beginFill(0x00ff00,0.3);
			liftBut.graphics.drawRect(0, 265, 200, 60);
			liftBut.graphics.endFill();			
			liftBut.buttonMode = true;
			liftBut.addEventListener(MouseEvent.CLICK, startLift );
			
			materialMask = new Sprite();
			materialMask.graphics.beginFill(0x00ff00,0.3);
			materialMask.graphics.drawRect(100, 30, 33, 33);
			materialMask.graphics.endFill();			
			materialMask.buttonMode = true;
			materialMask.addEventListener(MouseEvent.CLICK, removeMaterial);
			//addChild(materialMask);
			//liftBut.addEventListener(MouseEvent.CLICK, startLift );
			
			_this = this;
			scale = _scale;
			tester = _tester;
		}
		
		public function setReady(_diam:Number, _material:Material_C):void {
			diam = _diam;
			//определяем диаметр материала
			if(diam == 20){	
				this.gotoAndStop(2);
			}
			if(diam == 15){	
				this.gotoAndStop(156);				
			}
			//устанавливаем материал
			this.material = _material;
			//слушатель на кнопку
			liftBut.addEventListener(MouseEvent.CLICK, startLift );
			
			addChild(liftBut);			
		}
		
		
		public function startLift(e:MouseEvent):void {
			_this.play();
			_this.removeChild(liftBut);
			stopFrame = currentFrame + 50;
			addEventListener(Event.ENTER_FRAME, stopLift);	
			
			scale.bigArrow.startLocation();
			scale.smallArrow.startLocation();
		}
		
		private function stopLift(e:Event):void{
			if (currentFrame == stopFrame) {	
				stop();
				_this.addChild(liftBut);
				liftBut.removeEventListener(MouseEvent.CLICK, startLift );
				liftBut.addEventListener(MouseEvent.CLICK, startMove );
				removeEventListener(Event.ENTER_FRAME, stopLift);
			}
		}
		
		private function startMove(e:MouseEvent):void{
			play();
			_this.removeChild(liftBut);
			stopFrame = currentFrame + 60;
			addEventListener(Event.ENTER_FRAME, stopMove);
		}
		
		private function stopMove(e:Event):void{
			if (currentFrame == stopFrame) {	
				stop();
				_this.addChild(liftBut);
				liftBut.removeEventListener(MouseEvent.CLICK, startMove );
				liftBut.addEventListener(MouseEvent.CLICK, playSetting );
				removeEventListener(Event.ENTER_FRAME, stopMove);
			}
		}
		
		private function playSetting(e:MouseEvent):void{
			play();
			_this.removeChild(liftBut);
			stopFrame = currentFrame + 20;
			TweenLite.to(scale.scale, 0.8, {rotation:0 } );
			addEventListener(Event.ENTER_FRAME, stopSetting);
		}
		
		private function stopSetting(e:Event):void{
			if (currentFrame == stopFrame) {	
				stop();
				_this.addChild(liftBut);
				liftBut.removeEventListener(MouseEvent.CLICK, playSetting );
				liftBut.addEventListener(MouseEvent.CLICK, startLoad );
				removeEventListener(Event.ENTER_FRAME, stopSetting);
			}
		}
		
		private function startLoad(e:MouseEvent):void {
			gotoAndStop(currentFrame + 1);	
			play();
			removeChild(liftBut);
			stopFrame = currentFrame + 23;
			addEventListener(Event.ENTER_FRAME, stopLoad);
			if(material.getMark() == "20" && !material.isOtpusk){
				if(material.matNum == 1){
					TweenLite.to(scale.bigArrow, 0.8, { rotation: -160, onComplete:function():void { TweenLite.to(scale.bigArrow, 0.8, { rotation: 136.7 } ) }} );
				}
				if(material.matNum == 2){
					TweenLite.to(scale.bigArrow, 0.8, { rotation: -160, onComplete:function():void { TweenLite.to(scale.bigArrow, 0.8, { rotation: 133.3 } ) }} );
				}
				if(material.matNum == 3){
					TweenLite.to(scale.bigArrow, 0.8, { rotation: -160, onComplete:function():void { TweenLite.to(scale.bigArrow, 0.8, { rotation: 135 } ) }} );
				}
			}
			if(material.getMark() == "20" && material.isOtpusk){
				if(material.matNum == 1){
					TweenLite.to(scale.bigArrow, 0.8, { rotation: -160, onComplete:function():void { TweenLite.to(scale.bigArrow, 0.8, { rotation: 133.3 } ) }} );
				}
				if(material.matNum == 2){
					TweenLite.to(scale.bigArrow, 0.8, { rotation: -160, onComplete:function():void { TweenLite.to(scale.bigArrow, 0.8, { rotation: 94 } ) }} );
				}
				if(material.matNum == 3){
					TweenLite.to(scale.bigArrow, 0.8, { rotation: -160, onComplete:function():void { TweenLite.to(scale.bigArrow, 0.8, { rotation: 43.4 } ) }} );
				}
			}
			if(material.getMark() == "45" && !material.isOtpusk){
				if(material.matNum == 1){
					TweenLite.to(scale.bigArrow, 0.8, { rotation: -160, onComplete:function():void { TweenLite.to(scale.bigArrow, 0.8, { rotation: 197 } ) }} );
				}
				if(material.matNum == 2){
					TweenLite.to(scale.bigArrow, 0.8, { rotation: -160, onComplete:function():void { TweenLite.to(scale.bigArrow, 0.8, { rotation: 200.8 } ) }} );
				}
				if(material.matNum == 3){
					TweenLite.to(scale.bigArrow, 0.8, { rotation: -160, onComplete:function():void { TweenLite.to(scale.bigArrow, 0.8, { rotation: 199 } ) }} );
				}
			}
			if(material.getMark() == "45" && material.isOtpusk){
				if(material.matNum == 1){
					TweenLite.to(scale.bigArrow, 0.8, { rotation: -160, onComplete:function():void { TweenLite.to(scale.bigArrow, 0.8, { rotation: 186.8} ) }} );
				}
				if(material.matNum == 2){
					TweenLite.to(scale.bigArrow, 0.8, { rotation: -160, onComplete:function():void { TweenLite.to(scale.bigArrow, 0.8, { rotation: 140} ) }} );
				}
				if(material.matNum == 3){
					TweenLite.to(scale.bigArrow, 0.8, { rotation: -160, onComplete:function():void { TweenLite.to(scale.bigArrow, 0.8, { rotation: 79.8} ) }} );
				}
			}
			if(material.getMark() == "У12" && !material.isOtpusk){
				if(material.matNum == 1){
					TweenLite.to(scale.bigArrow, 0.8, { rotation: -160, onComplete:function():void { TweenLite.to(scale.bigArrow, 0.8, { rotation: 233 } ) }} );
				}
				if(material.matNum == 2){
					TweenLite.to(scale.bigArrow, 0.8, { rotation: -160, onComplete:function():void { TweenLite.to(scale.bigArrow, 0.8, { rotation: 230 } ) }} );
				}
				if(material.matNum == 3){
					TweenLite.to(scale.bigArrow, 0.8, { rotation: -160, onComplete:function():void { TweenLite.to(scale.bigArrow, 0.8, { rotation: 236.5 } ) }} );
				}
				if(material.matNum == 4){
					TweenLite.to(scale.bigArrow, 0.8, { rotation: -160, onComplete:function():void { TweenLite.to(scale.bigArrow, 0.8, { rotation: 119 } ) }} );
				}
				if(material.matNum == 5){
					TweenLite.to(scale.bigArrow, 0.8, { rotation: -160, onComplete:function():void { TweenLite.to(scale.bigArrow, 0.8, { rotation: 94 } ) }} );
				}
			}
			if(material.getMark() == "У12" && material.isOtpusk){
				if(material.matNum == 1){
					TweenLite.to(scale.bigArrow, 0.8, { rotation: -160, onComplete:function():void { TweenLite.to(scale.bigArrow, 0.8, { rotation: 222.8 } ) }} );
				}
				if(material.matNum == 2){
					TweenLite.to(scale.bigArrow, 0.8, { rotation: -160, onComplete:function():void { TweenLite.to(scale.bigArrow, 0.8, { rotation: 172.2 } ) }} );
				}
				if(material.matNum == 3){
					TweenLite.to(scale.bigArrow, 0.8, { rotation: -160, onComplete:function():void { TweenLite.to(scale.bigArrow, 0.8, { rotation: 108.1 } ) }} );
				}
			}
		}
		
		private function stopLoad(e:Event):void{
			if (currentFrame == stopFrame) {	
				stop();
				addChild(materialMask);
				liftBut.removeEventListener(MouseEvent.CLICK, startLoad );
				removeEventListener(Event.ENTER_FRAME, stopLoad);
				
			}
		}
		
		private function rebootStage():void{
			TweenLite.to(scale.bigArrow,1,{rotation:-180})
			TweenLite.to(scale.scale, 0.5, {rotation:-14 } );
		}
		
		private function removeMaterial(e:MouseEvent):void {
			material.gotoStartPosotion(2);
			material.alpha = 1;
			this.material = null
			tester.setReady();
			rebootStage();
			removeChild(materialMask);
			gotoAndStop(1);
			tester.isReady = false;
			var stageIsReady:Boolean = true;
			for (var i:Number = 0; i < tester.st.material20.length;i++ ){
				if(tester.st.material20[i].isHardTest1 == false){
					stageIsReady = false;
				}				
			}
			for (var i:Number = 0; i < tester.st.material45.length;i++ ){
				if(tester.st.material45[i].isHardTest1 == false){
					stageIsReady = false;
				}				
			}
			for (var k:Number = 0; k < tester.st.materialU12.length;k++ ){
				if(tester.st.materialU12[k].isHardTest1 == false){
					stageIsReady = false;
				}				
			}
			if(stageIsReady)
				phazesInfo.buttons[3].setAvailable();
		}
	}

}