package stages 
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;
	import Interface.PhazesInfo;
	import stages.bucket.Bucket_C;
	import stages.material.Material_C;
	import stages.Table.Table_C;
	import com.greensock.*;
	/**
	 * ...
	 * @author Yury Nikolaev
	 */
	public class StageOne_C extends Sprite
	{
		private var background:Sprite;
		private var oven:Oven_C;
		private var table:Table_C;
		private var waterBucket:Bucket_C;
		private var oilBucket:Bucket_C;
		private var material20:Vector.<Material_C> = new Vector.<Material_C>;
		private var material45:Vector.<Material_C> = new Vector.<Material_C>;
		private var materialU12:Vector.<Material_C> = new Vector.<Material_C>;
		private var tongs:Tongs_C;
		private var _this:Sprite;
		
		private var phazesButton:PhazesInfo;
		
		private var caliper:Caliper_C;
		
		public function StageOne_C(_width:Number, _height:Number, _phazesButton:PhazesInfo) 
		{	
			phazesButton = _phazesButton;
			_this = this;
			//фон сцены
			background = new Sprite();
			background.graphics.beginFill(0xffffff);
			background.graphics.drawRect(0, 48, 1024, 768);
			background.graphics.endFill();
			addChild(background);
			//печь
			oven = new Oven_C();
			oven.y = background.height + 48 - oven.height;
			oven.handle.addEventListener(MouseEvent.CLICK, function():void{
				for (var i:int = 0; i < 3;i++ ){				
					material20[i].setActive();
				}
				for (var i:int = 0; i < 3;i++ ){
					material45[i].setActive();
				}
				for (var i:int = 0; i < 5; i++ ) {
					materialU12[i].setActive();
				}
			});
			oven.closeHandle.addEventListener(MouseEvent.CLICK, function():void { 
				for (var i:int = 0; i < 3;i++ ){				
					material20[i].setUnActive();
				}
				for (var i:int = 0; i < 3;i++ ){
					material45[i].setUnActive();
				}
				for (var i:int = 0; i < 5; i++ ) {
					materialU12[i].setUnActive();
				}
			} );
			addChild(oven);
			//штанген циркуль
			caliper = new Caliper_C();
			caliper.x = background.width - caliper.width - 40;
			caliper.setStartPosition(caliper.x);
			caliper.y = 90;
			//стол
			table = new Table_C();
			table.y = background.height + 48 - table.height;
			table.x = background.width - table.width;
			addChild(table);
			//ведрj с водой
			waterBucket = new Bucket_C("Ведро с водой");
			waterBucket.y = table.y - 235;
			waterBucket.x = table.x + waterBucket.width;
			addChild(waterBucket);
			//ведро с маслом
			oilBucket = new Bucket_C("Ведро с маслом");
			oilBucket.y = table.y - 220;
			oilBucket.x = table.x + 2 * oilBucket.width;
			addChild(oilBucket);
			//материал сталь20
			for (var i:int = 0; i < 3;i++ ){
				material20[i] = new Material_C(table.x + 60 + i * 20, table.y + 45 - i * 7,oven,"20",i,caliper,"вода");
				material20[i].y = table.y + 45 - i * 7;
				material20[i].x = table.x + 60 + i * 20;
				material20[i].setDiam (15);
				material20[i].setCurrentStage(1);
				addChild(material20[i]);
				material20[i].setSize(1);
				material20[i].setTypeOfCooling("water");	
				
				material20[i].setUnActive();
			}
			//материал сталь45
			for (var i:int = 0; i < 3;i++ ){
				material45[i] = new Material_C(table.x + 100 + i * 20, table.y + 51 - i * 7,oven,"45",i,caliper,"вода");
				material45[i].y = table.y + 51 - i * 7;
				material45[i].x = table.x + 100 + i * 20;
				material45[i].setDiam(20);
				material45[i].setCurrentStage(1);
				addChild(material45[i]);
				material45[i].setSize(1);
				material45[i].setTypeOfCooling("water");
				
				material45[i].setUnActive();
			}
			//материал стальУ12
			for (var i:int = 0; i < 5; i++ ) {
				if(i < 3)	
					materialU12[i] = new Material_C(table.x + 140 + i * 20, table.y + 56 - i * 7, oven, "У12", i, caliper,"вода");
				else if (i == 3)
					materialU12[i] = new Material_C(table.x + 140 + i * 20, table.y + 56 - i * 7, oven, "У12", i, caliper,"масло");
				else if (i == 4)
					materialU12[i] = new Material_C(table.x + 140 + i * 20, table.y + 56 - i * 7, oven, "У12", i, caliper,"воздух");
				materialU12[i].y = table.y + 56 - i * 7;
				materialU12[i].x = table.x + 150 + i * 20;
				materialU12[i].setDiam(20);
				materialU12[i].setCurrentStage(1);
				addChild(materialU12[i]);
				materialU12[i].setSize(1);
				if(i < 3){
					materialU12[i].setTypeOfCooling("water");
				}
				else if (i == 3){
					materialU12[i].setTypeOfCooling("oil");
				}
				else if (i == 4){
					materialU12[i].setTypeOfCooling("air");
				}
				
				materialU12[i].setUnActive();
			}
			
			//щипцы
			tongs = new Tongs_C(705,625, oven, waterBucket, oilBucket, material20);
			tongs.x = 710;
			tongs.y = 630;
			tongs.addEventListener(MouseEvent.MOUSE_DOWN, downHandl);
			tongs.addEventListener(MouseEvent.MOUSE_UP, upHandl);
			//tongs.mouseEnabled = false;
			
		
			//caliper.setReady(null);
			addChild(caliper);
			
			addChild(tongs);
		}
		
		private function pickMaterial(e:MouseEvent):void {
			if(tongs.getMaterial() != null){
				addChild(tongs.getMaterial());
			}
			tongs.setMaterial(e.currentTarget as Material_C);
			removeChild(e.currentTarget as Material_C);
			
			//if(!e.currentTarget.isHeated && !e.currentTarget.isLoad){
				//tongs.gotoAndStop(3);
				//tongs.setMaterial(e.currentTarget as Material_C);	
				//
				//if(oven.loadedMaterials.length == 0){
					//e.currentTarget.isLoad = true;
					//
					//if (e.currentTarget.loadIndex == -5){
						//e.currentTarget.loadIndex = oven.loadedMaterials.length;
					//}
					//oven.loadedMaterials.splice(e.currentTarget.loadIndex, 0, e.currentTarget as Material_C);
					//
					//e.currentTarget.alpha = 0;
					//e.currentTarget.x = 150 + 40 * (e.currentTarget.loadIndex); 
					//e.currentTarget.y = 425;
				//}
				//else if(oven.loadedMaterials[0].getMark() == e.currentTarget.getMark()){
					//e.currentTarget.isLoad = true;
					//
					//if (e.currentTarget.loadIndex == -5){
						//e.currentTarget.loadIndex = oven.loadedMaterials.length;
					//}
					//oven.loadedMaterials.splice(e.currentTarget.loadIndex, 0, e.currentTarget as Material_C);
					//
					//if (e.currentTarget.loadIndex < 3) {
						//e.currentTarget.alpha = 0;	
						//e.currentTarget.x = 150 + 40 * (e.currentTarget.loadIndex); 
						//e.currentTarget.y = 425;
					//}
					//else {
						//e.currentTarget.alpha = 0;	
						//e.currentTarget.x = 170 + 40 * (e.currentTarget.loadIndex-3); 
						//e.currentTarget.y = 438;
					//}						
					//
					//if((oven.loadedMaterials.length == 3 && (oven.loadedMaterials[0].getMark() == "20" || oven.loadedMaterials[0].getMark() == "45")) || (oven.loadedMaterials.length == 5 && (oven.loadedMaterials[0].getMark() == "У12"))){//добавить для 5 материалов
						//oven.isLoad = true;
					//}
				//}
			//}
		}
		
		public function resize(_width:Number, _height:Number):void{	
			this.height = _height - 48;
			this.width = this.height * 4 / 3;
			this.x = _width / 2 - this.width / 2;	
		}
		
		public function setActive():void{
			this.mouseEnabled = true;
			this.mouseChildren = true;
			this.alpha = 1;
			
			for (var i:int = 0; i < 3;i++ ){
				material20[i].y = table.y + 45 - i * 7;
				material20[i].x = table.x + 60 + i * 20;
				material20[i].setCurrentStage(1);
				material20[i].setSize(1);
				addChild(material20[i]);	
				material20[i].addEventListener(MouseEvent.CLICK, pickMaterial);
			}
			
			for (var i:int = 0; i < 3;i++ ){
				material45[i].y = table.y + 51 - i * 7;
				material45[i].x = table.x + 100 + i * 20;
				material45[i].setCurrentStage(1);
				addChild(material45[i]);
				material45[i].setSize(1);
				material45[i].addEventListener(MouseEvent.CLICK, pickMaterial);
			}
			
			for (var i:int = 0; i < 5;i++ ){				
				materialU12[i].y = table.y + 56 - i * 7;
				materialU12[i].x = table.x + 150 + i * 20;
				materialU12[i].setCurrentStage(1);
				addChild(materialU12[i]);
				materialU12[i].setSize(1);
				materialU12[i].addEventListener(MouseEvent.CLICK, pickMaterial);
			}
		}
		
		public function setUnActive():void {
			for (var i:int = 0; i < 3;i++ ){
				material20[i].removeEventListener(MouseEvent.CLICK, pickMaterial);
			}	
			this.mouseEnabled = false;
			this.mouseChildren = false;
			this.alpha = 0;
		}
		
		public function getmaterial20():Vector.<Material_C>{
			return material20;
		}
		
		public function getmaterial45():Vector.<Material_C>{
			return material45;
		}
		
		public function getmaterialU12():Vector.<Material_C>{
			return materialU12;
		}
		
		private function downHandl(e:MouseEvent):void{
			tongs.startDrag();
			tongs.isPicked = true;
			tongs.mouseEnabled = false;
			tongs.mouseChildren = false;
			
			var point:Point = new Point(mouseX, mouseY);
			
			trace(this.x);
			trace(point.x);
			
			tongs.x = point.x;
			tongs.y = point.y;
						
			addChild(tongs);
			addEventListener(MouseEvent.MOUSE_UP, upHandl);
		}
		var timer:Timer = new Timer(1500, 1);
		
		private function upHandl(e:MouseEvent):void {
			
			tongs.isPicked = false;
			var point:Point = localToGlobal(new Point(mouseX, mouseY));
			
			
			if (waterBucket.hitTestPoint(point.x, point.y) && tongs.isGrab && tongs.getMaterial().getTypeOfCooling() == "water") {	
				trace(1212);
				waterBucket.isAllow = true;
				waterBucket.planmtm();
				tongs.gotoAndStop(1);
				tongs.alpha = 0;
				tongs.mouseEnabled = false;
				tongs.mouseChildren = false;
				timer.start();
				tongs.getMaterial().isCooled = true;
				tongs.getMaterial().isLoad = false;
			}
			else if (oilBucket.hitTestPoint(point.x, point.y) && tongs.isGrab && tongs.getMaterial().getTypeOfCooling() == "oil") {
				oilBucket.isAllow = true;
				oilBucket.planmtm();
				tongs.gotoAndStop(1);
				tongs.alpha = 0;
				tongs.mouseEnabled = false;
				tongs.mouseChildren = false;
				timer.start();
				tongs.getMaterial().isCooled = true;
				tongs.getMaterial().isLoad = false;
			}
			else if (tongs.isGrab && tongs.getMaterial().getTypeOfCooling() == "air") {
				tongs.gotoAndStop(1);				
				TweenLite.to(tongs.getMaterial(), 2, { onComplete:function():void { 
						_this.mouseEnabled = true;
						_this.mouseChildren = true;
						tongs.getMaterial().gotoAndStop(1);
						tongs.dropMaterial();
					}} 
					);
				tongs.dropMaterial();	
				tongs.getMaterial().isCooled = true;
				tongs.mouseEnabled = true;
				tongs.mouseChildren = true;
				tongs.getMaterial().isLoad = false;
			}
			else if(!tongs.isGrab){ //ошибка
				
				waterBucket.count = 0;	
				waterBucket.isAllow = false;
				tongs.dropMaterial();	
				oilBucket.count = 0;	
				oilBucket.isAllow = false;
				tongs.mouseEnabled = true;
				tongs.mouseChildren = true;
			}
			
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, function():void { 
				tongs.alpha = 1; 
				tongs.getMaterial().mouseEnabled = false;
				tongs.getMaterial().mouseChildren = false;
				tongs.dropMaterial();
				tongs.mouseEnabled = true;
				tongs.mouseChildren = true;
				_this.mouseEnabled = true;
				_this.mouseChildren = true;
				} );
			
			var stageIsReady:Boolean = true;
			for (var i:Number = 0; i < material20.length;i++ ){
				if(material20[i].isCooled == false){
					stageIsReady = false;
				}				
			}
			for (var i:Number = 0; i < material45.length;i++ ){
				if(material45[i].isCooled == false){
					stageIsReady = false;
				}				
			}
			for (var k:Number = 0; k < materialU12.length;k++ ){
				if(materialU12[k].isCooled == false){
					stageIsReady = false;
				}				
			}
			if(stageIsReady){
				phazesButton.buttons[2].setAvailable();
			}
			
			tongs.mouseEnabled = true;
			tongs.mouseChildren = true;
			tongs.x = 705;
			tongs.y = 625;
		}
	}

}