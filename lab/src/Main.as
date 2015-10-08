package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import Interface._scrollBar.ScrollBar_C;
	import Interface.MainBanner;
	import Interface.PhazesInfo;
	import Interface.PhazeTwo_C;
	import stages.Preview;
	import stages.StageOne_C;

	/**
	 * ...
	 * @author Yury Nikolaev
	 */
	[Frame(factoryClass="Preloader")]
	public class Main extends Sprite 
	{
		private var mainBan:MainBanner;
		private var stageInfo:StageInfo;
		private var scrollBar:ScrollBar_C;
		private var phazesInfo:PhazesInfo;
		
		
		private var stages:Array = new Array();
		private var preview:Preview;
		private var stageOne:StageOne_C;
		private var stageTwo:StageTwo_C;
		private var stageThree:StageThree;
		private var stageFour:StageTwo_C;

		public function Main() 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}

		private function init(e:Event = null):void 
		{
			stage.addEventListener(Event.RESIZE, onResStage);
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
						
			//рисуем баннер
			mainBan = new MainBanner(stage.stageWidth, stage.stageHeight);
			addChild(mainBan);
			
			//рисуем скроллбар
			scrollBar = new ScrollBar_C(stage);	
			//scrollBar.mouseEnabled = false;
			scrollBar.alpha = 1;
			//scrollBar.mouseChildren = false;
			addChildAt(scrollBar, 0);
			
			//рисуем информацию о сценах и кнопки переключения
			phazesInfo = new PhazesInfo(stage.stageWidth, stage.stageHeight);
			addChildAt(phazesInfo,1);
			phazesInfo.setStages(stages);
			
			//превью
			preview = new Preview("preview.flv");
			addChildAt(preview,0);
			stages[0] = preview;
			////первая сцена
			stageOne = new StageOne_C(stage.stageWidth, stage.stageHeight,phazesInfo);			
			addChildAt(stageOne, 0);
			stages[1] = stageOne;
			//stages.push(stageOne);
			stageOne.setUnActive();
			
			//вторая сцена
			stageTwo = new StageTwo_C(stage.stageWidth, stage.stageHeight, phazesInfo);
			stages[2] = stageTwo;
			
			stageTwo.setMaterial20(stageOne.getmaterial20());//передаем материал
			stageTwo.setMaterial45(stageOne.getmaterial45());
			stageTwo.setMaterialU12(stageOne.getmaterialU12());
			
			stageTwo.setUnActive();
			addChildAt(stageTwo, 0);
			
			//третья сцена
			stageThree = new StageThree(phazesInfo);
			stages[3] = stageThree;
			stageThree.setUnActive();
			addChildAt(stageThree, 0);
			stageThree.setMaterial20(stageOne.getmaterial20());//передаем материал
			stageThree.setMaterial45(stageOne.getmaterial45());
			stageThree.setMaterialU12(stageOne.getmaterialU12());
			//четвертая сцена
			
			//stageFour = new StageFour();
			//stages[4] = stageFour;
			//stageFour.setUnActive();
			//addChildAt(stageFour, 0);			
			//stageFour.setMaterial20(stageOne.getmaterial20());//передаем материал изменить измеритель твердости
			//stageFour.setMaterial45(stageOne.getmaterial45());
			//stageFour.setMaterialU12(stageOne.getmaterialU12());
			
					
			
			
			//перерисовываем
			onResStage(null);
		}

		public function onResStage(e:Event):void{
			mainBan.onRes(stage.stageWidth, stage.stageHeight);
			phazesInfo.onRes(stage.stageWidth, stage.stageHeight);
			scrollBar.onRes(stage.stageHeight);
			
			//перерисовка сцен
			preview.onRes(stage.stageWidth, stage.stageHeight);
			stageOne.resize(stage.stageWidth, stage.stageHeight);
			stageTwo.resize(stage.stageWidth, stage.stageHeight);
			stageThree.resize(stage.stageWidth, stage.stageHeight);
			//stageFour.resize(stage.stageWidth, stage.stageHeight);
		}
		
		public function reboot():void {
			//первая сцена
			stageOne = null;
			stageOne = new StageOne_C(stage.stageWidth, stage.stageHeight,phazesInfo);			
			addChildAt(stageOne, 0);
			stages[1] = stageOne;
			stageOne.setUnActive();
			
			
			//вторая сцена
			stageTwo = null;			
			stageTwo = new StageTwo_C(stage.stageWidth, stage.stageHeight, phazesInfo);
			stages[2] = stageTwo;
			
			stageTwo.setMaterial20(stageOne.getmaterial20());//передаем материал
			stageTwo.setMaterial45(stageOne.getmaterial45());
			stageTwo.setMaterialU12(stageOne.getmaterialU12());
			
			stageTwo.setUnActive();
			addChildAt(stageTwo, 0);
			
			//третья сцена
			stageThree = null;
			stageThree = new StageThree(phazesInfo);
			stages[3] = stageThree;
			stageThree.setUnActive();
			addChildAt(stageThree, 0);
			stageThree.setMaterial20(stageOne.getmaterial20());//передаем материал
			stageThree.setMaterial45(stageOne.getmaterial45());
			stageThree.setMaterialU12(stageOne.getmaterialU12());
			//перерисовка
			onResStage(null);
		}
	}

}