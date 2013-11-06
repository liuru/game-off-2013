package
{
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	public class Mewsic extends Engine
	{
		public static var INSTANCE:Mewsic;
		public static var WIDTH:int = 800;
		public static var HEIGHT:int = 600;
		public function Mewsic()
		{
			super(WIDTH, HEIGHT, 60, false);
			FP.world = new MainWorld;
			INSTANCE = this;
		}
		
		override public function init():void
		{
			
		}
	}
}