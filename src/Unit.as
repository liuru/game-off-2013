package
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.utils.Draw;
	
	public class Unit extends Entity
	{
		public var direction:Vec2;
		public var lineOfSight: LineOfSight;
		public var speed: Number;
		public var hasDestination:int = 0;
		
		
		//0 means listening, 1 means wandering
		public var wandering:int = 1;
		
		//time it takes to transition between listening and wandering
		public var reflexTime:int = C.REFLEX_TIME;
		
		public var path:Path;
		
		public var destination:Vec2 = new Vec2(200,200);
		
		public function Unit() {
			direction = new Vec2(1, 0);
			type = "human"
			this.setHitbox(C.PLAYER_RADIUS*2, C.PLAYER_RADIUS*2);
		}
		
		public function randomWalk():void{
			
			
			var dir:int;
			if(Math.random()<0.01){
				dir = FP.rand(4);
			}
			if(collide("wall", x + direction.x*C.PLAYER_RADIUS, y + direction.y*C.PLAYER_RADIUS)|| 
				collide("human", x + direction.x*C.PLAYER_RADIUS, y + direction.y*C.PLAYER_RADIUS)||
				collide("player", x + direction.x*C.PLAYER_RADIUS, y + direction.y*C.PLAYER_RADIUS)	
			){
				dir = FP.rand(2) + 1;
				
			}
			
			direction.rotate(-Math.PI/2*dir);
			var directionScaled:Vec2 = direction.copy();
			directionScaled.scale(speed);
			
			this.moveTowards(x+directionScaled.x, y+directionScaled.y, FP.elapsed*speed, ["player"]);
			
			x%= C.MAP_WIDTH;
			y%= C.MAP_HEIGHT;
			
			if(x <=0){
				x = C.MAP_WIDTH;
			}
			
			if(y <=0){
				y = C.MAP_HEIGHT;
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
				reflexTime = 0;
				hasDestination = 1;
			}
			
		}
		public function decreaseAttention():void{
			if(reflexTime < C.REFLEX_TIME){
				reflexTime += 1;
				
				hasDestination = 0;
				wandering = 0;
				if(reflexTime >=C.REFLEX_TIME){
					wandering = 1;
					reflexTime = C.REFLEX_TIME;
				}
			}
		}
		
		public override function render():void{
			super.render();
			if(wandering == 0){
				if(path!=null){
					for(var i:int= 1; i < path.interPoints.length;i++){
						Draw.line(path.interPoints[i].x, path.interPoints[i].y, path.interPoints[i-1].x, path.interPoints[i-1].y);
					}
				}
			}
			Draw.hitbox(this);
		}
		
		
	}
}