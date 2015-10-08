package 
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import Interface.PhazesInfo;
	import stages.Otpusk.OvenOtpusk_C;
	import stages.Table.Table_C;
	import stages.material.Material_C;
	/**
	 * ...
	 * @author Yury Nikolaev
	 */
	public class StageThree extends Sprite
	{
		private var background:Sprite;
		
		private var oven1:OvenOtpusk_C;
		private var oven2:OvenOtpusk_C;
		
		private var oven3:OvenOtpusk_C;
		private var maskForWire:Sprite;	
		private var table:Table_C;
		
		private var material20:Vector.<Material_C> = new Vector.<Material_C>;
		private var material45:Vector.<Material_C> = new Vector.<Material_C>;
		private var materialU12:Vector.<Material_C> = new Vector.<Material_C>;
		
		private var phazesButton:PhazesInfo;
		
		public function StageThree(_phazesButton:PhazesInfo) 
		{
			phazesButton = _phazesButton;
			
			//фон сцены
			background = new Sprite();
			background.graphics.beginFill(0xffffff);
			background.graphics.drawRect(0, 48, 1024, 768);
			background.graphics.endFill();
			addChild(background);
			
			oven1 = new OvenOtpusk_C(1);
			oven1.y = background.height + 48 - oven1.height;
			oven1.addEventListener(MouseEvent.CLICK, checkReady );
			addChild(oven1);
			
			oven2 = new OvenOtpusk_C(2);
			oven2.y = background.height + 48 - oven2.height;
			oven2.x = oven1.width - 65;
			oven2.addEventListener(MouseEvent.CLICK, checkReady );
			addChild(oven2);
			
			oven3 = new OvenOtpusk_C(3);
			oven3.y = background.height + 48 - oven3.height;
			oven3.x = oven1.width + oven2.width - 125;
			oven3.addEventListener(MouseEvent.CLICK, checkReady );
			addChild(oven3);
			maskForWire = new Sprite();
			maskForWire.graphics.beginFill(0xffffff);
			maskForWire.graphics.drawRect(oven3.x + oven3.width - 90, oven3.y + 245, 100, 30);
			maskForWire.graphics.endFill();
			addChild(maskForWire);
			
			//стол
			table = new Table_C();
			table.y = background.height - table.height + 86;
			table.x = background.width - table.width - 100;
			table.height = 200;
			addChild(table);
		}
		
		public function setActive():void {
			this.alpha = 1;		
			this.mouseEnabled = true;
			this.mouseChildren = true;
			
			for (var i:Number = 0; i < material20.length;i++ ) {
					addChild(material20[i]);
					material20[i].x = material20[i].startX;
					material20[i].y = material20[i].startY;
					material20[i].setCurrentStage(3);
					material20[i].setSize(1);
				}
			for (var i:Number = 0; i < material45.length;i++ ){
					addChild(material45[i]);
					material45[i].x = material45[i].startX;
					material45[i].y = material45[i].startY;
					material45[i].setCurrentStage(3);
					material45[i].setSize(1);
				}
			for (var i:Number = 0; i < 3;i++ ){
					addChild(materialU12[i]);
					materialU12[i].x = materialU12[i].startX;
					materialU12[i].y = materialU12[i].startY;
					materialU12[i].setCurrentStage(3);
					materialU12[i].setSize(1);
				}
		}
		
		public function setUnActive():void {
			this.alpha = 0;	
			this.mouseEnabled = false;
			this.mouseChildren = false;
		}
		
		public function resize(_width:Number, _height:Number):void{	
			this.height = _height - 48;
			this.width = this.height * 4 / 3;
			this.x = _width / 2 - this.width / 2;
		}
		
		public function setMaterial20(_material20:Vector.<Material_C>):void{
			this.material20 = _material20;
			for (var i:Number = 0; i < _material20.length;i++ ){
				material20[i].setOvenOtpusk(oven1, oven2, oven3);
			}
		}
		
		public function setMaterial45(_material45:Vector.<Material_C>):void{
			this.material45 = _material45;	
			for (var i:Number = 0; i < _material45.length;i++ ){
				material45[i].setOvenOtpusk(oven1, oven2, oven3);
			}
		}
		
		public function setMaterialU12(_materialU12:Vector.<Material_C>):void{
			this.materialU12 = _materialU12;
			for (var i:Number = 0; i < _materialU12.length;i++ ){
				materialU12[i].setOvenOtpusk(oven1, oven2, oven3);
			}
		}	
		
		private function checkReady(e:MouseEvent):void{
			if(oven1.isLoad && oven2.isLoad && oven3.isLoad){
				phazesButton.buttons[4].setAvailable();
			}
		}
	}

}