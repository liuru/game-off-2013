package
{
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	public class Mewsic extends Engine
	{
		public static var INSTANCE:Mewsic;
		public function Mewsic()
		{
			super(C.GAME_WIDTH, C.GAME_HEIGHT, 60, false);
			FP.world = new MainWorld;
			INSTANCE = this;
		}
		
		override public function init():void
		{
			
		}
	}
}