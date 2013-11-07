package
{
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.utils.Draw;
	import net.flashpunk.FP;
	
	public class Enemy extends Entity
	{
		public var direction:int;
		public function Enemy(x:Number=0, y:Number=0, graphic:Graphic=null, mask:Mask=null)
		{
			direction = FP.rand(4);
			x = FP.rand(C.MAP_WIDTH);
			y = FP.rand(C.MAP_HEIGHT);
			super(x, y, graphic, mask);
		}
		override public function update():void
		{
			if(Math.random()<0.01){
				direction = FP.rand(4);
			}
			switch(direction)
				{
					case 0:
						x+=C.GUARD_SPEED;
						break;
					case 2:
						y+=C.GUARD_SPEED;
						break;
					case 3:
						x-=C.GUARD_SPEED;
						break;
					default:
						y-=C.GUARD_SPEED;
				}
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
			super.render();
			
			Draw.circle(x, y, C.PLAYER_RADIUS, 0xF00F00);
			
		}
		
	}
}