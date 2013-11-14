package
{
	import net.flashpunk.Entity;
	import net.flashpunk.utils.Draw;

	public class Wall extends Entity {
		public function Wall(x:int, y:int) {
			this.x = x;
			this.y = y;
			this.setHitbox(20, 20);
			this.type = "wall";
		}
		override public function render():void {
			Draw.hitbox(this);
		}
	}
}