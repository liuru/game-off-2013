package
{
	import lit.*;
	
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.utils.Draw;
	
	public class Civilian extends Unit
	{
		
		//unhappypoints
		public var happy_points:int = 0;
		public var happy_cooldown:int = C.HAPPY_COOLDOWN;
		
		public var light:Light;
	
		public function Civilian ()
		{
			super();
			x = FP.rand(C.MAP_WIDTH);
			y = FP.rand(C.MAP_HEIGHT);
			setHitbox(C.PLAYER_RADIUS*2, C.PLAYER_RADIUS*2);
			this.speed = C.CIVILLIAN_SPEED;
			this.light = new Light(0, 0, C.SPR_LIGHT_CIRCLE_GRADIENT_IMG, 1, 0.8);
			
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
			
			light.alpha = Math.max(happy_points / C.HAPPY_METER_MAX, 0.1);
			light.x = this.x + C.TILE_HALF;
			light.y = this.y + C.TILE_HALF;
			decreaseHappy();
		}
		public override function chargeAttention(poi:Vec2, p:Player):void{
			super.chargeAttention(poi, p);
			if(hasDestination == 1){
				destination = poi;
				increaseHappy();
				if(happy_points > C.HAPPY_METER_MAX){
					//the player got a coin
					p.getCoins(1);
					hasDestination=0;	
				}
			}
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