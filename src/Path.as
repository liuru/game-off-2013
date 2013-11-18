package
{
	public class Path
	{
		public var interPoints:Array;
		private var curIndex:int;
		public var curX:Number;
		public var curY:Number;
		public function Path(s:Vec2, d:Vec2, ip:Array ){
			
			interPoints = ip;
			curX = s.x;
			curY = s.y;
			
		}
		//we say this when a function is close enough to the destination to be called the destination
		public function isDestination(pos:Vec2):Boolean{
			var diff:Vec2 = Vec2.diff(pos, interPoints[interPoints.length-1]);
			if(diff.abs() < C.CLOSE_ENOUGH){
				return true;
			}
			return false;
		}
		
		public function updateIndex(pos:Vec2):void{
		
			var diff:Vec2 = Vec2.diff(pos, interPoints[curIndex]);
			if(diff.abs() < C.CLOSE_ENOUGH){
				curIndex+=1;
				if(curIndex < interPoints.length){
					this.curX = interPoints[curIndex].x;
					this.curY = interPoints[curIndex].y;
				}
			}
		}
		public function isDone():Boolean{
			return curIndex >= interPoints.length;
		}
	}
}