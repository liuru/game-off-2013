package
{
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.utils.Draw;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	public class Player extends Entity
	{
		
		
		public var singing:int;
		public var coins: int;
		public function Player(x:Number=0, y:Number=0, graphic:Graphic=null, mask:Mask=null)
		{
			x = 400;
			y = 200;
			super(x, y, graphic, mask);
			
		
		}
		
		override public function update():void
		{
			sing();
			if(singing == 0){
				move();
			}
		
		}
		
		public function sing():void{
			if (Input.check(Key.SPACE))
			{
				singing = 1;
			}
			else{
				singing = 0;
			}
		}
		
		public function move():void{
			if (Input.check(Key.UP))
			{
				y-=C.PLAYER_SPEED;
			}
			if (Input.check(Key.DOWN))
			{
				y+=C.PLAYER_SPEED;
			}
			
			if (Input.check(Key.RIGHT))
			{
				x+=C.PLAYER_SPEED;
			}
			
			if (Input.check(Key.LEFT))
			{
				x-=C.PLAYER_SPEED;
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
		
		public function getCoins(i:int):void{
			coins+=i;
		}
		
		override public function render():void
		{
			super.render();
			if(singing == 0){
				Draw.circle(x, y, C.PLAYER_RADIUS, 0x00FF00);
			}
			else{
				
				Draw.circle(x, y, C.PLAYER_RADIUS, 0xF0F0F0);
			
			}
		}
		
		
		
	}
}