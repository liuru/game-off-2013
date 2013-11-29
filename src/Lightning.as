package {
	import lit.Light;

	import net.flashpunk.FP;
	import net.flashpunk.Entity;
	import net.flashpunk.Tween;
	import net.flashpunk.tweens.misc.VarTween;

	public class Lightning extends Entity {
		public var light:Light;
		
		public var lastStrike:int;
		
		public function Lightning() {
			light = new Light(0, 0, C.SPR_LIGHT_CIRCLE_GRADIENT_IMG, 50, 0.2);
		}
		
		public override function update():void {
			if (FP.random < 0.01) {
				light.alpha = 1.0;
				FP.log('LIGHTNING');
			}
			light.alpha = light.alpha * 0.8;
		}
	}
}