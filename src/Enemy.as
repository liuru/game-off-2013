package
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.utils.Draw;
	
	public class Enemy extends Unit
	{
		public var aggro: int;
		public var aggroCooldown: Number;
		public var destination: Vec2;
		public function Enemy() {
			super();
			aggro = 0;
			x = FP.rand(C.MAP_WIDTH);
			y = FP.rand(C.MAP_HEIGHT);
			lineOfSight = new LineOfSight(this);
			type = "human";
			destination = new Vec2(0, 0);
			this.speed = C.GUARD_SPEED;
			
		}
		override public function update():void
		{
			if(aggro == 0){
				randomWalk();
			}
			else{
				
				this.moveTowards(destination.x, destination.y, FP.elapsed*C.GUARD_SPEED, ["human", "player", "wall"]);
				
			}
		}
		override public function render():void
		{	super.render();
			lineOfSight.render();
			Draw.circle(x + C.PLAYER_RADIUS, y + C.PLAYER_RADIUS, C.PLAYER_RADIUS, 0xF00F00);
			
		}
		
	}
}