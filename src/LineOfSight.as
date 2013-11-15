package
{
	import net.flashpunk.FP;
	import net.flashpunk.utils.Draw;
	import net.flashpunk.Entity;
	
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	
	public class LineOfSight
	{
		
		public var theta:Number;
		//TODO: refactor this to be general for player, civ, and enemies
		public var enemy:Enemy;
		
		public function LineOfSight( e:Enemy)
		{
			this.enemy = e;
			
		}
	 	public function render():void{
			var dir:Vec2 = enemy.direction.copy();
			dir.normalize();
			Draw.line(enemy.x, enemy.y, enemy.x + dir.x * C.SIGHT_RADIUS,enemy.y + dir.y * C.SIGHT_RADIUS); 
			
			
		}

		
	}
}