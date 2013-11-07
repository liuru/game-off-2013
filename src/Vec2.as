package
{
	public class Vec2
	{
		public var x:Number;
		public var y:Number;
		public function Vec2(x:Number, y:Number)
		{
			this.x = x;
			this.y = y;
			
		}
		
		public function normalize():void{
			var d:Number = x*x + y*y;
			d = Math.sqrt(d);
			if(d!= 0){
				x/=d;
				y/=d;
			}
		
		}
		
		public function abs():Number{
			return Math.sqrt(x*x + y*y);
		
		}
		
		public function scale(k:Number):void{
			x = x*k;
			y = y*k;
		}
		
		
		public static function sum(a:Vec2, b:Vec2 ):Vec2{
			
			return new Vec2(a.x + b.x, a.y + b.y);
		}
		
		public static function diff(a:Vec2, b:Vec2 ):Vec2{
			
			return new Vec2(a.x - b.x, a.y - b.y);
		}
		
		
	}
}