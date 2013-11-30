package {
	import lit.Light;
	
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Tween;
	import net.flashpunk.tweens.misc.VarTween;
	import net.flashpunk.utils.*;

	public class Weather extends Entity {
		public var light:Light;
		
		public var lastStrike:int;
		
		public function Weather() {
			this.layer = -100;
			light = new Light(0, 0, C.SPR_LIGHT_CIRCLE_GRADIENT_IMG, 50, 0.2);
		}
		
		public override function update():void {
			if (FP.random < 0.01) {
				light.alpha = 1.0;
				FP.log('LIGHTNING');
			}
			light.alpha = light.alpha * 0.8;
		}
		
		public override function render():void {
			for(var x:int=0; x<C.GAME_WIDTH; x++) {
				if(FP.random < 0.04) {
					var intensity:Number = FP.random * 55 + 200;
					Draw.line(x, 0, x, FP.random * C.GAME_HEIGHT, FP.getColorRGB(intensity, intensity, intensity), 0.5);
				}
			}
			
		
		}
	}
}