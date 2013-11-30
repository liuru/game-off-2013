package
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.tweens.sound.SfxFader;
	import net.flashpunk.utils.Draw;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	
	public class Player extends Unit
	{
		
		public var singing:int;
		public var coins: int;
		private var sm:Spritemap;
		private var fader:SfxFader;
		
		public function Player() {
			x = 4 * 16;
			y = 4 * 16;
			type = "player";
			setHitbox(C.PLAYER_RADIUS*2, C.PLAYER_RADIUS*2);
			this.sm = SpriteLoader.getPlayerSpriteMap();
			this.graphic = this.sm;
			
			C.BGM.loop(0.0);
			fader = new SfxFader(C.BGM);
			addTween(fader);
		}
		
		override public function update():void {
			if(Input.check(Key.Z)) {				
				FP.screen.scale += 0.1;
			}
			
			if (Input.mouseDown) {
				if(singing == 0) {
					fader.fadeTo(1.0, 2);
				}
				singing = 1;
			} else {
				if(singing == 1) fader.fadeTo(0.0, 0.5);
				singing = 0;
			}
			if(singing == 0) {
				var targetX:int = FP.world.mouseX - 8;
				var targetY:int = FP.world.mouseY - 8;
				
				if(this.x != targetX && this.y != targetY) {
					this.moveTowards(targetX, targetY, FP.elapsed*C.PLAYER_SPEED, ["human", "wall"]);
					this.sm.play("walk");
				} else {
					this.sm.play("idle");
				}
			}
		}
		
		public function getCoins(i:int):void {
			coins+=i;
		}
		
		override public function render():void {
			super.render();
			if(singing){
				Draw.circle(x + C.PLAYER_RADIUS, y + C.PLAYER_RADIUS, C.PLAYER_RADIUS, 0x00FF00);
			}
		}
		
		
		
	}
}