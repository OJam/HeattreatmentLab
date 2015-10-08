package stages.hardness 
{
	import com.greensock.TweenLite;
	import com.greensock.easing.*;
	/**
	 * ...
	 * @author Yury Nikolaev
	 */
	public class BigArrow extends HardArrBig
	{
		
		public function BigArrow() 
		{
			this.height = 145;
			this.width = 12;
			
			this.rotation = -180;
		}
		
		public function startLocation():void{
			TweenLite.to(this, 2.1, { rotation:(360 * 2), ease:Linear.easeNone } );
		}
	}

}