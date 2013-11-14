package
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.utils.Draw;
	
	public class Enemy extends Entity
	{
		public var direction:int;
		public var lineOfSight: LineOfSight;
		public function Enemy(x:Number=0, y:Number=0, graphic:Graphic=null, mask:Mask=null)
		{
			direction = FP.rand(4);
			x = FP.rand(C.MAP_WIDTH);
			y = FP.rand(C.MAP_HEIGHT);
			lineOfSight = new LineOfSight(this);
			super(x, y, graphic, mask);
		}
		override public function update():void
		{
			if(Math.random()<0.01){
				direction = FP.rand(4);
				
				
			}
			
			//TODO: REFACTOR. OMG SO BAD
			var unit:Vec2 = new Vec2(1, 0);
			unit.scale(C.GUARD_SPEED);
			
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
			lineOfSight.update();
		}
		override public function render():void
		{
			super.render();
			lineOfSight.render();
			Draw.circle(x, y, C.PLAYER_RADIUS, 0xF00F00);
			
		}
		
	}
}