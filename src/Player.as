package
{
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.utils.Draw;
	
	public class Player extends Entity
	{
		
		public function Player(x:Number=0, y:Number=0, graphic:Graphic=null, mask:Mask=null)
		{
			x = 400;
			y = 200;
			super(x, y, graphic, mask);
			
		
		}
		
		override public function update():void
		{
			if (Input.check(Key.UP))
			{
				y-=7;
			}
			if (Input.check(Key.DOWN))
			{
				y+=7;
			}
			
			if (Input.check(Key.RIGHT))
			{
				x+=7;
			}
			
			if (Input.check(Key.LEFT))
			{
				x-=7;
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
			
			Draw.circle(x, y, 30, 0x00FF00);
			
		}
		
		
	}
}