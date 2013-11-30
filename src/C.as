package
{
	import net.flashpunk.Sfx;
	import net.flashpunk.graphics.Image;

	public class C
	{
		
		public static var GAME_WIDTH:int = 20 * 16;
		public static var GAME_HEIGHT:int = 16 * 16;

		public static var TILE_SIZE:int = 16;
		public static var TILE_HALF:int = TILE_SIZE/2;

		public static var MAP_WIDTH:int = 20 * 16;
		public static var MAP_HEIGHT:int = 16 * 16;
	
		public static var MAP_TILE_WIDTH:int = 16;
		public static var MAP_TILE_HEIGHT:int = 16;
		
		public static var SINGING_RADIUS:int = 50;
		public static var HEARING_RADIUS:int = 100;
		public static var PLAYER_RADIUS:int = 8;
		public static var SIGHT_RADIUS:int = 40;
		
		//how much time it takes to get unhappy;
		public static var HAPPY_COOLDOWN:int = 250;
		
		//how much time it takes to get happy;
		public static var HAPPY_METER_MAX:int = 50;
		
		//how much time it takes for civilians to transfer from wandering to not wandering
		public static var REFLEX_TIME:int = 20;
		
		
		public static var PLAYER_SPEED:Number = 100;
		public static var GUARD_SPEED:int = 100;
		public static var CIVILLIAN_SPEED:int = 90;

		
		//people move slower when they are following musicmews
		public static var BESPELLED_SPEED:int = 80;
		
		//how long police will follow you 
		public static var AGGRO_COOLDOWN:int = 50;
		
		public static var CLOSE_ENOUGH:int = 5;
		
		
		// some global graphics
		[Embed(source = "res/circle_gradient.png")]
		public static const SPR_LIGHT_CIRCLE_GRADIENT:Class;
		public static var SPR_LIGHT_CIRCLE_GRADIENT_IMG:Image = new Image(SPR_LIGHT_CIRCLE_GRADIENT);
		SPR_LIGHT_CIRCLE_GRADIENT_IMG.centerOrigin();
		
		// main music piece
		[Embed(source = "res/in-time.mp3")]
		public static const BGM_CLASS:Class;
		public static var BGM:Sfx = new Sfx(BGM_CLASS);

	}
}