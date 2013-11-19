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
				if(path !=null){
					if(!path.isDone()){
						path.updateIndex(new Vec2(x, y));
						this.moveTowards(path.curX, path.curY, FP.elapsed*C.GUARD_SPEED, ["human", "player", "wall"]);
						
					}
					else{
						this.moveTowards(path.curX, path.curY, FP.elapsed*C.GUARD_SPEED, ["human", "player", "wall"]);
						
					}
				}
				else{
					this.moveTowards(destination.x, destination.y, FP.elapsed*C.GUARD_SPEED, ["human", "player", "wall"]);
				}
			}
			
		}
		
		public override function chargeAttention(poi:Vec2, p:Player):void{
			super.chargeAttention(poi, p);
			if(hasDestination == 1){
				if(path != null ){
					if(!path.isDestination(poi)){
						path = AStar.search(new Vec2(this.x, this.y), poi);
					}
				}
				else{
					
					path = AStar.search(new Vec2(this.x, this.y), poi);
				}
				
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