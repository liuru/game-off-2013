package {
	import lit.Light;
	
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Sfx;
	import net.flashpunk.Tween;
	import net.flashpunk.tweens.misc.VarTween;
	import net.flashpunk.utils.*;

	public class Weather extends Entity {
		public var light:Light;
		
		private var time:Number = 0;
		private var lastStrike:Number;
		
		[Embed(source = "res/rain.mp3")]
		private static const RAIN_CLASS:Class;
		private static var RAIN:Sfx = new Sfx(RAIN_CLASS);
		
		[Embed(source = "res/thunder.mp3")]
		private static const THUNDER_CLASS:Class;
		private var thunder_buffer:Vector.<Sfx>;
		private var thunder_idx:int;
		
		
		public function Weather() {
			thunder_buffer = new Vector.<Sfx>();
			for(var i:int = 0; i<5; i++) {
				thunder_buffer.push(new Sfx(THUNDER_CLASS));
			}
			
			this.layer = -100;
			light = new Light(0, 0, C.SPR_LIGHT_CIRCLE_GRADIENT_IMG, 50, 0.2);
			RAIN.loop(0.5);
			
			FP.watch(1);
				
			
		}
		
		public override function update():void {
			time += FP.elapsed;
			
			
			if (FP.random < 0.008) {
				
				if(time - lastStrike > 1.0 && FP.random > 0.5) {
					FP.log('THUNDER', thunder_idx);
					thunder_buffer[thunder_idx].play();
					thunder_idx = (thunder_idx + 1) % 5;	
				}
				
				
				light.alpha = 1.0;
				lastStrike = time;
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