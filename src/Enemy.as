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
			type = "human";
			destination = new Vec2(0, 0);
			this.speed = C.GUARD_SPEED;
			
		}
		override public function update():void
		{
			if(hasDestination == 0){
				if(wandering == 1){
					randomWalk();
				}
			}
			else{
				this.moveTowards(destination.x, destination.y, FP.elapsed*C.GUARD_SPEED, ["human", "player", "wall"]);
				
			}
		}
		
		public override function chargeAttention(poi:Vec2, p:Player):void{
			super.chargeAttention(poi, p);
			if(hasDestination == 1){
				destination = poi;
				
			}
		}
		
		override public function render():void
		{	super.render();
			lineOfSight.render();
			Draw.circle(x + C.PLAYER_RADIUS, y + C.PLAYER_RADIUS, C.PLAYER_RADIUS, 0xF00F00);
			
		}
		
	}
}