package stages.Otpusk 
{
	import flash.display.SpreadMethod;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import stages.material.Material_C;
	import stages.Oven.Arrow_C;
	/**
	 * ...
	 * @author Yury Nikolaev
	 */
	public class OvenOtpusk_C extends OvenOtpusk_mc
	{
		private var openHandle:Sprite;
		public var closeHandle:Sprite;
		public var ovenMask:Sprite;
		private var arrow:Arrow_C;
		private var bottomArrow:ArrOtpusk_C;
		
		public var isLoad:Boolean = false;
		
		private var material20:Material_C = null;
		private var material45:Material_C = null;
		private var materialU12:Material_C = null;	
		
		
		private var ovenNumber:Number;
		
		public function OvenOtpusk_C(_ovenNumber:Number) 
		{
			ovenNumber = _ovenNumber;
			this.gotoAndStop(1);
			//ручка открытия
			openHandle = new Sprite();
			openHandle.graphics.beginFill(0x00ff00, 0.3);
			openHandle.graphics.drawRect(285, 105, 42, 15);
			openHandle.graphics.endFill();
			openHandle.buttonMode = true;
			addChild(openHandle);
			openHandle.addEventListener(MouseEvent.CLICK, openOven);
			//ручка закрытия
			closeHandle = new Sprite();
			closeHandle.graphics.beginFill(0x00ff00, 0.3);
			closeHandle.graphics.drawRect(25, 120, 20, 20);
			closeHandle.graphics.endFill();
			closeHandle.buttonMode = true;
			closeHandle.addEventListener(MouseEvent.CLICK, closeOven);
			//маска на печь
			ovenMask = new Sprite();
			ovenMask.graphics.beginFill(0x00ff00);
			ovenMask.graphics.drawRoundRect(125, 80, 108, 80, 20);
			ovenMask.alpha = 0.3;
			ovenMask.buttonMode = true;
			
			//стрелка температуры
			bottomArrow = new ArrOtpusk_C();
			if (_ovenNumber == 1) {
				bottomArrow.x = 72.3;			
			}
			if (_ovenNumber == 2) {
				bottomArrow.x = 90;			
			}
			if (_ovenNumber == 3) {
				bottomArrow.x = 102;			
			}
			
			bottomArrow.y = 290;
			bottomArrow.height = 24;
			bottomArrow.width = 3;
			addChild(bottomArrow);
			
			//стрелка на амперметре
			arrow = new Arrow_C();
			arrow.x = 188;
			arrow.y = 412;
			arrow.rotation = -70;
			addChild(arrow);
		}
		
		private function openOven(e:MouseEvent):void{
			this.gotoAndStop(2);
			//this.addChild(closeHandle);
			this.removeChild(openHandle);
			this.addChild(ovenMask);
			if(material20){
				parent.addChild(material20);
				parent.addChild(material45);
				parent.addChild(materialU12);
			}
		}
		
		private function closeOven(e:MouseEvent):void {
		//добавить таймер для отпуска и разрешить mouseenabled по окончанию	
			this.gotoAndStop(1);			
			this.removeChild(closeHandle);
			this.removeChild(ovenMask);
			if(material20 != null && material45 != null && materialU12 != null){
				isLoad = true;
			}
			else{
				this.addChild(openHandle);
			}
			if(material20 && material45 && materialU12){
				parent.removeChild(material20);
				parent.removeChild(material45);
				parent.removeChild(materialU12);
				
				material20.isOtpusk = true;
				material45.isOtpusk = true;
				materialU12.isOtpusk = true;		
			}
		}
		public function setMaterial(_mat:Material_C):void{
			if (_mat.getMark() == "20" && material20 == null) {
				material20 = _mat;				
				
				if(ovenNumber == 1){
					material20.x = 140;
					material20.y = 380;
				}
				if (ovenNumber == 2) {
					//if(!_mat.getIsLoadOtpusk()){	
						material20.x = 470;
						material20.y = 380;
					//}
				}
				if (ovenNumber == 3) {
					//if(!_mat.getIsLoadOtpusk()){	
						material20.x = 820;
						material20.y = 380;
					//}
				}
				_mat.mouseEnabled = false;
				_mat.mouseChildren = false;
				_mat.setIsLoadOtpusk(true);
			}else if(material20 != null && !_mat.getIsLoadOtpusk()){
				_mat.x = _mat.startX;
				_mat.y = _mat.startY;
			}
			if (_mat.getMark() == "45" && material45 == null){
				material45 = _mat;
				
				
				if(ovenNumber == 1){
					material45.x = 175;
					material45.y = 380;
				}
				if(ovenNumber == 2){
					material45.x = 505;
					material45.y = 380;
				}
				if (ovenNumber == 3) {
					//if(!_mat.getIsLoadOtpusk()){	
						material45.x = 850;
						material45.y = 380;
					//}
				}
				_mat.mouseEnabled = false;
				_mat.mouseChildren = false;
				_mat.setIsLoadOtpusk(true);
			}else if(material45 != null && !_mat.getIsLoadOtpusk()){
				_mat.x = _mat.startX;
				_mat.y = _mat.startY;
			}
			if (_mat.getMark() == "У12" && materialU12 == null) {
				materialU12 = _mat;
				
				
				if(ovenNumber == 1){
					materialU12.x = 205;
					materialU12.y = 380;
				}
				if(ovenNumber == 2){
					materialU12.x = 535;
					materialU12.y = 380;
				}
				if (ovenNumber == 3) {
					//if(!_mat.getIsLoadOtpusk()){	
						materialU12.x = 885;
						materialU12.y = 380;
					//}
				}
				_mat.mouseEnabled = false;
				_mat.mouseChildren = false;
				_mat.setIsLoadOtpusk(true);
			}else if(materialU12 != null && !_mat.getIsLoadOtpusk()){
				_mat.x = _mat.startX;
				_mat.y = _mat.startY;
			}
			
			if(material20 != null && material45 != null && materialU12 != null){
				addChild(closeHandle);
			}
		}
		
		public function getMaterial20():Material_C{
			return material20;
		}
		public function getMaterial45():Material_C{
			return material45;
		}
		public function getMaterialU12():Material_C{
			return materialU12;
		}
		
		public function getMask():Sprite{
			return ovenMask;
		}
	}

}