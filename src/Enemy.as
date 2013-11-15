package
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.utils.Draw;
	
	public class Enemy extends Unit
	{
		public function Enemy() {
			super();
			
			x = FP.rand(C.MAP_WIDTH);
			y = FP.rand(C.MAP_HEIGHT);
			lineOfSight = new LineOfSight(this);
			this.speed = C.GUARD_SPEED;
			direction.scale(speed);
		}
		override public function update():void
		{
			randomWalk();
		}
		override public function render():void
		{	super.render();
			lineOfSight.render();
			Draw.circle(x + C.PLAYER_RADIUS, y + C.PLAYER_RADIUS, C.PLAYER_RADIUS, 0xF00F00);
			
		}
		
	}
}