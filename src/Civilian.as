package
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.utils.Draw;
	
	public class Civilian extends Entity
	{
		public var direction:int;
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
			direction = FP.rand(4);
			x = FP.rand(C.MAP_WIDTH);
			y = FP.rand(C.MAP_HEIGHT);
			setHitbox(C.PLAYER_RADIUS*2, C.PLAYER_RADIUS*2);
			type = "human"
		}
		override public function update():void
		{
			if(hasDestination == 0){
				if(wandering == 1){
					move();	
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
			
			diff.normalize();
			diff.scale(C.BESPELLED_SPEED);
			x+=diff.x;
			y+=diff.y;
			
			
		}
		
		public function move():void{
		
			if(Math.random()<0.01){
				direction = FP.rand(4);
			}
			
			
			var unit:Vec2 = new Vec2(1, 0);
			unit.scale(C.CIVILLIAN_SPEED);
			
			//TODO: refactor direction to be stored in this class
			
			unit.rotate(-Math.PI/2*direction);
			
			x +=unit.x;
			y +=unit.y;
			
			x%= C.MAP_WIDTH;
			y%= C.MAP_HEIGHT;
			
			if(x <=0){
				x = C.MAP_WIDTH;
			}
			
			if(y <=0){
				y = C.MAP_HEIGHT;
			}
			
		}
		
		override public function render():void
		{
			Draw.circlePlus(x, y, (happy_points / C.HAPPY_METER_MAX) * C.PLAYER_RADIUS)
			
			if(happy_points < C.HAPPY_METER_MAX){
				Draw.circle(x, y, C.PLAYER_RADIUS, 0x0000FF);
			}
			else{
				Draw.circle(x, y, C.PLAYER_RADIUS, 0xF0F00F);
			}
			
		}
		
		
		
	}
}