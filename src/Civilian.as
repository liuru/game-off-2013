package
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.utils.Draw;
	
	public class Civilian extends Unit
	{
		public var hasDestination:int = 0;
		
		//0 means listening, 1 means wandering
		public var wandering:int = 1;
		
		//time it takes to transition between listening and wandering
		public var reflexTime:int = C.REFLEX_TIME;
		
		//unhappypoints
		public var happy_points:int = 0;
		public var happy_cooldown:int = C.HAPPY_COOLDOWN;	
		
		
		public var destination:Vec2 = new Vec2(200,200);
		public function Civilian ()
		{
			super();
			x = FP.rand(C.MAP_WIDTH);
			y = FP.rand(C.MAP_HEIGHT);
			setHitbox(C.PLAYER_RADIUS*2, C.PLAYER_RADIUS*2);
			this.speed = C.CIVILLIAN_SPEED;
			
		}
		override public function update():void
		{
			if(hasDestination == 0){
				if(wandering == 1){
					randomWalk();
				}
			}
			else {
				moveTowardsDest();
			}
			
			decreaseHappy();
			
			
		}
		public function decreaseHappy():void{
			//I'm happy, I need to wait to become unhappy
			if(happy_points > C.HAPPY_METER_MAX){
				happy_cooldown -=1;
				//ok, now I'm unhappy again
				if(happy_cooldown <=0){
					happy_points = 0;
					happy_cooldown = C.HAPPY_COOLDOWN;
					
				}
			}
			else{
				//if I'm not listening to music
				if(wandering == 1){
					happy_points--;
					happy_points = Math.max(0, happy_points);
				}
			}
		
		}
	
		
		//charges attention towards a point of interest
		public function chargeAttention(poi:Vec2,p:Player):void{
			
			
			//the person stops, but does not move towards the destination until the period wears off
			if(reflexTime >= 0){
				reflexTime -=1;
				wandering = 0;
			}
			else{
			
				hasDestination = 1;
				
				destination = poi;
				increaseHappy();
				if(happy_points > C.HAPPY_METER_MAX){
					//the player got a coin
					p.getCoins(1);
					
					hasDestination=0;
					
				}
			}
				
		}
		public function decreaseAttention():void{
			if(reflexTime < C.REFLEX_TIME){
			reflexTime += 1;
				if(reflexTime >=C.REFLEX_TIME){
					wandering = 1;
					hasDestination = 0;
				}
			}
		}
		
		
		public function increaseHappy():void{
			if(happy_points <= C.HAPPY_METER_MAX){
				happy_points++;
			}
			
		}
		
		public function moveTowardsDest():void{
			
			var loc:Vec2 = new Vec2(x, y);
			var diff:Vec2 = Vec2.diff(destination, loc);
			if(diff.abs() < C.SINGING_RADIUS){
				
				hasDestination = 0;
				return;
			}
			
		
			this.moveTowards(destination.x, destination.y, FP.elapsed*C.BESPELLED_SPEED, ["human", "player", "wall"]);
			
		}
		
	
		
		override public function render():void
		{
			super.render();
			Draw.circlePlus(x+C.PLAYER_RADIUS, y+C.PLAYER_RADIUS, (happy_points / C.HAPPY_METER_MAX) * C.PLAYER_RADIUS)
			
			if(happy_points < C.HAPPY_METER_MAX){
				Draw.circle(x+C.PLAYER_RADIUS, y+C.PLAYER_RADIUS, C.PLAYER_RADIUS, 0x0000FF);
			}
			else{
				Draw.circle(x + C.PLAYER_RADIUS, y + C.PLAYER_RADIUS, C.PLAYER_RADIUS, 0xF0F00F);
			}
			
		}
		
		
		
	}
}