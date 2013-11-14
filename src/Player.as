package
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.utils.Draw;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	
	public class Player extends Entity
	{
		
		public var singing:int;
		public var coins: int;
		public function Player()
		{
			x = 400;
			y = 200;
			type = "player";
			setHitbox(C.PLAYER_RADIUS*2, C.PLAYER_RADIUS*2);
			
		
		}
		
		override public function update():void
		{
			if (Input.mouseDown) {
				singing = 1;
			} else {
				singing = 0;
			}
			if(singing == 0){
				this.moveTowards(FP.world.mouseX, FP.world.mouseY, FP.elapsed*C.PLAYER_SPEED, ["human", "wall"]);
			}
		
		}
		
		public function getCoins(i:int):void{
			coins+=i;
		}
		
		override public function render():void
		{
			super.render();
			if(singing == 0){
				Draw.circle(x + C.PLAYER_RADIUS, y + C.PLAYER_RADIUS, C.PLAYER_RADIUS, 0x00FF00);
			}
			else{
				
				Draw.circle(x + C.PLAYER_RADIUS, y + C.PLAYER_RADIUS, C.PLAYER_RADIUS, 0xF0F0F0);
			
			}
			
			Draw.hitbox(this);
		}
		
		
		
	}
}