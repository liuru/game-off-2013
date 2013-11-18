package
{
	import flash.utils.ByteArray;
	
	public class LevelLoader
	{
		
		[Embed(source="res/level1.json", mimeType="application/octet-stream")]
		private static const Level1:Class;
		
		public static function getLevel1():Object {
			return parse(Level1);
		}

		private static function parse(p_class:Class):Object {
			var b:ByteArray = new p_class();
			var s:String = b.readUTFBytes(b.length);
			return JSON.parse(s);
		}
	}
}