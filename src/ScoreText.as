package {	
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Text;
	
	public class ScoreText extends Entity {
		private var score:int = 0;
		private var text:Text;
		
		public function ScoreText() {
			this.graphic = (text = new Text("$0"));
			this.layer = -2000;
		}
		public function setScore(score:int): void {
			this.score = score;
		}
		public override function update(): void {
			text.text = "$"+score;
		}
	}
}