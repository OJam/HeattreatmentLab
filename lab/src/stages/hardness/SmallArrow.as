package stages.hardness 
{
	import com.greensock.TweenLite;
	import com.greensock.easing.*;	
	/**
	 * ...
	 * @author Yury Nikolaev
	 */
	public class SmallArrow extends HardArrSmall
	{
		
		public function SmallArrow() 
		{
			this.width = 12;
			this.height = 34;
		}
		
		public function startLocation():void{
			TweenLite.to(this, 2.1, { rotation:(360 * 1), ease:Linear.easeNone } );
		}
	}

}