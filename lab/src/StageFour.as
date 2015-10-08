package 
{
	import flash.display.Sprite;
	import stages.hardness.HardnessTester_C;
	import stages.material.Material_C;
	/**
	 * ...
	 * @author Yury Nikolaev
	 */
	public class StageFour extends Sprite
	{
		private var background:Sprite;
		private var hardnessTester:HardnessTester_C;
		
		private var material20:Vector.<Material_C> = new Vector.<Material_C>;
		private var material45:Vector.<Material_C> = new Vector.<Material_C>;
		private var materialU12:Vector.<Material_C> = new Vector.<Material_C>;
		
		public function StageFour() 
		{
			//фон сцены
			background = new Sprite();
			background.graphics.beginFill(0xffffff);
			background.graphics.drawRect(0, 48, 1024, 768);
			background.graphics.endFill();
			addChild(background);
			
			//измеритель твердости
			hardnessTester = new HardnessTester_C();
			hardnessTester.y = 100;
			hardnessTester.x = background.width - hardnessTester.width - 150;
			addChild(hardnessTester);
		}
		
		public function setActive():void{
			this.mouseEnabled = true;
			this.mouseChildren = true;
			this.alpha = 1;
			for (var i:Number = 0; i < material20.length;i++ ) {
				addChild(material20[i]);
				material20[i].x = 200 + i * 60;
				material20[i].y = 400 - 20 * i;
				material20[i].startX2 = material20[i].x;
				material20[i].startY2 = material20[i].y;
				material20[i].setCurrentStage(4);
				material20[i].setSize(2);
			}
			
			for (var i:Number = 0; i < material45.length;i++ ){
				addChild(material45[i]);
				material45[i].x = 200 + (i+1) * 60;
				material45[i].y = 450 - 20 * i;
				material45[i].startX2 = material45[i].x;
				material45[i].startY2 = material45[i].y;
				material45[i].setCurrentStage(4);
				material45[i].setSize(2);
			}
			
			for (var i:Number = 0; i < 3;i++ ){
				addChild(materialU12[i]);
				materialU12[i].x = 200 + (i+2) * 60;
				materialU12[i].y = 500 - 20 * i;
				materialU12[i].startX2 = materialU12[i].x;
				materialU12[i].startY2 = materialU12[i].y;
				materialU12[i].setCurrentStage(4);
				materialU12[i].setSize(2);
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
			for (var i:Number = 0; i < material20.length; i++ ) {
				_material20[i].setHardnessTester(hardnessTester);
			}
		}
		
		public function setMaterial45(_material45:Vector.<Material_C>):void{
			this.material45 = _material45;
			for (var i:Number = 0; i < _material45.length;i++ ){
				_material45[i].setHardnessTester(hardnessTester);
			}
		}
		
		public function setMaterialU12(_materialU12:Vector.<Material_C>):void{
			this.materialU12 = _materialU12;
			for (var i:Number = 0; i < _materialU12.length;i++ ){
				_materialU12[i].setHardnessTester(hardnessTester);
			}
		}
	}

}