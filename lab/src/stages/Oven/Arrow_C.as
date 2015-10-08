package stages.Oven 
{
	import com.greensock.TweenLite;
	import com.greensock.easing.*;
	/**
	 * ...
	 * @author Yury Nikolaev
	 */
	public class Arrow_C extends Arrow_mc
	{
		
		public function Arrow_C() 
		{
			this.width = 2;
			this.height = 50;
			this.y = 457;
			this.x = 202;
			
			this.rotation = -90;
		}
		
		public function setRotation(degree:Number):void{
			TweenLite.to(this, 1, {ease:Back.easeOut.config(0.8), rotation:degree } );
		}
	}

}