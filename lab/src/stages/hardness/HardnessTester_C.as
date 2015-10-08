package stages.hardness 
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import Interface.PhazesInfo;
	import stages.hardness.LiftPlace_C;
	import stages.material.Material_C;
	import stages.Oven.Arrow_C;
	/**
	 * ...
	 * @author Yury Nikolaev
	 */
	public class HardnessTester_C extends HardnessTester_mc
	{		
		private var liftPlace:LiftPlace_C;
		private var materialPlaceMask:Sprite;
		private var scale:Scale_C;
		private var indicator:Indicator_C;
		
		private var currentMaterial:Material_C;
		public var st:StageTwo_C;
		
		public var isReady:Boolean = false;
		
		public function HardnessTester_C( _phazesButton:PhazesInfo, _st:StageTwo_C) 
		{			
			st = _st;
			
			scale = new Scale_C();
			scale.y = 52;
			scale.x = 110;
			addChild(scale);
			
			indicator = new Indicator_C();
			addChild(indicator);
			
			liftPlace = new LiftPlace_C(scale, this,_phazesButton);
			liftPlace.x = -6;
			liftPlace.y = 217;			
			addChild(liftPlace);		
			
			materialPlaceMask = new Sprite();
			materialPlaceMask.graphics.beginFill(0x00ff00, 0.3);
			materialPlaceMask.graphics.drawEllipse(65, 260, 85, 20);
			materialPlaceMask.graphics.endFill();			
			addChild(materialPlaceMask);
						
		}
		
		
		public function setReadyToMeasure(_material:Material_C):void {
			if (currentMaterial == null) {
				isReady = true;	
				currentMaterial = _material;
				currentMaterial.alpha = 0;
				currentMaterial.mouseEnabled = false;
				currentMaterial.mouseChildren = false;			
				removeChild(materialPlaceMask);			
				liftPlace.setReady(currentMaterial.getDiam(), currentMaterial);
			}
		}	
		
		public function setReady():void{
			addChild(materialPlaceMask);
			
			
			currentMaterial.mouseEnabled = true;
			currentMaterial.mouseChildren = true;
			currentMaterial = null;
		}
	}

}