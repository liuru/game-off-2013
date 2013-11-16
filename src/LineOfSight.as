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
			
			if(enemy.hasDestination == 0){
				var dir:Vec2 = enemy.direction.copy();
				dir.normalize();
				
				Draw.line(enemy.x + C.PLAYER_RADIUS, enemy.y + C.PLAYER_RADIUS, enemy.x + C.PLAYER_RADIUS + dir.x * C.SIGHT_RADIUS,enemy.y + C.PLAYER_RADIUS + dir.y * C.SIGHT_RADIUS); 
			}
			else{
			
				
				var dirD:Vec2 = new Vec2(enemy.destination.x - enemy.x, enemy.destination.y - enemy.y);
				dirD.normalize();
				
				Draw.line(enemy.x + C.PLAYER_RADIUS, enemy.y + C.PLAYER_RADIUS, enemy.x + C.PLAYER_RADIUS + dirD.x * C.SIGHT_RADIUS,enemy.y + C.PLAYER_RADIUS + dirD.y * C.SIGHT_RADIUS); 
			}
			
		}

		
	}
}