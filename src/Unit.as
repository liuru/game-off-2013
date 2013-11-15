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
		public function Unit() 
		{
			direction = new Vec2(1, 0);
			type = "human"
			this.setHitbox(C.PLAYER_RADIUS*2, C.PLAYER_RADIUS*2);
		}
		
		public function randomWalk():void{
			
			
			var dir:int;
			if(Math.random()<0.01){
				dir = FP.rand(4);
			}
			var w:Wall = collide("wall", x + direction.x*C.PLAYER_RADIUS, y + direction.y*C.PLAYER_RADIUS) as Wall;
			if(w){
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
		
		public override function render():void{
			super.render();
			
			Draw.hitbox(this);
		}
		
		
	}
}