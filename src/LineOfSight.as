package
{
	import net.flashpunk.FP;
	import net.flashpunk.utils.Draw;
	import net.flashpunk.Entity;
	
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	
	public class LineOfSight extends Entity
	{
		
		public var theta:Number;
		//TODO: refactor this to be general for player, civ, and enemies
		public var enemy:Enemy;
		
		public function LineOfSight( e:Enemy, x:Number=0, y:Number=0, graphic:Graphic=null, mask:Mask=null)
		{
			this.enemy = e;
			super(x, y, graphic, mask);
			
			
		}
		override public function update():void{
			x = enemy.x;
			y = enemy.y;
		}
		override public function render():void{
			var unit:Vec2 = new Vec2(C.SIGHT_RADIUS, 0);
			
			//TODO: refactor direction to be stored in this class
			
			unit.rotate(-Math.PI/2*enemy.direction);
			
			
			Draw.line(enemy.x, enemy.y, enemy.x +unit.x,enemy.y +unit.y); 
		
			
		}

		
	}
}