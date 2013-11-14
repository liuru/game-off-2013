package
{
	import net.flashpunk.World;
	
	public class MainWorld extends World
	{
		
		internal var civilians:Array = [];
		internal var enemies:Array = [];
		internal var player:Player;
		internal var counter:int = 0;
		public function MainWorld()
		{
			super();
			
			player = new Player();
			
			for(var i:int = 0; i < 2; i++){
				enemies.push(new Enemy());
			}
			for(i = 0; i < 9; i++){
				civilians.push(new Civilian());
			}
			add(player);
			
			for each(var e:Enemy in enemies){
				
				add(e);
			}
			for each(var c:Civilian in civilians){
				add(c);
			}
			
		}
		
		
		override public function update():void
		{
			super.update();
			
			counter++;
			var playerP:Vec2 = new Vec2(player.x, player.y);
			for each(var c:Civilian in civilians){
				
				if(player.singing == 0){
					c.decreaseAttention();
				}
				else {
					var loc:Vec2 = new Vec2(c.x, c.y);
					var diff:Vec2 = Vec2.diff(playerP, loc);
					
					if(diff.abs() > C.HEARING_RADIUS|| c.happy_points > C.HAPPY_METER_MAX){
						c.decreaseAttention();
					}
					else{
						if(c.happy_points <= C.HAPPY_METER_MAX){
							
							c.chargeAttention(playerP, player);
						}
						
					}
				}
			}
		}
		
		
		
		
		
	}
}