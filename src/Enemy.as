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
			x = FP.rand(Mewsic.WIDTH);
			y = FP.rand(Mewsic.HEIGHT);
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
						x+=5;
						break;
					case 2:
						y+=5;
						break;
					case 3:
						x-=5;
						break;
					default:
						y-=5;
				}
			x%= Mewsic.WIDTH;
			y%= Mewsic.HEIGHT;
			
			if(x <=0){
				x = Mewsic.WIDTH;
			}
			
			if(y <=0){
				y = Mewsic.HEIGHT;
			}
			
		}
		override public function render():void
		{
			super.render();
			
			Draw.circle(x, y, 30, 0xF00F00);
			
		}
		
	}
}