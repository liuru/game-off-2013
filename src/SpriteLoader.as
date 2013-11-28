package
{
	import net.flashpunk.graphics.Spritemap;

	public class SpriteLoader
	{
		
		
		
		
		[Embed(source = 'res/spritesheet.png')]
		private static const SPRITESHEET:Class;
		private static const WIDTH:int=16;
		private static const HEIGHT:int=16;
		
		public static function getPlayerSpriteMap():Spritemap {
			var spr:Spritemap = new Spritemap(SPRITESHEET, WIDTH, HEIGHT);
			spr.add("walk", [0, 1, 2, 3], 8, true);
			spr.add("idle", [0], 8, true);
			return spr
		}
	}
}