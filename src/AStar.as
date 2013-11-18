package
{
	import flash.utils.Dictionary;

	public class AStar
	{
		public static function search(s:Vec2, g:Vec2):Path{
			//turn the sizes into tile size
			var start:Vec2 = s.copy();
			var goal:Vec2 = g.copy();
			start.x = int(start.x/ C.TILE_SIZE);
			start.y= int(start.y/ C.TILE_SIZE);
			
			goal.x = int(goal.x/ C.TILE_SIZE);
			goal.y = int(goal.y/ C.TILE_SIZE);
			
			var curMap:Object = LevelLoader.getLevel1().map;
			var closedset:Array = new Array(curMap.length); // The set of nodes already evaluated.
			var g_score:Array = [[],[]]; // The set of nodes already evaluated.
			var f_score:Array = [[],[]];
			
			for(var i:int = 0; i<curMap[0].length; i++) {  
				closedset[i] = new Array(curMap[0].length);
				g_score[i] = new Array(curMap[0].length);
				f_score[i] = new Array(curMap[0].length);
				for(var j:int = 0; j<curMap[0].length; j++) {   
					closedset[i][j] = 0;
					g_score[i][j] = 0;
					f_score[i][j] = 0;
				} 
				
			}

			
			var openset:Array = new Array(start);    // The set of tentative nodes to be evaluated, initially containing the start node
			var came_from:Dictionary = new Dictionary();    // The map of navigated nodes.
			
			g_score[start.x][start.y] = 0    // Cost from start along best known path.
			// Estimated total cost from start to goal through y.
			f_score[start.x][start.y] = f_score[start.x][start.y] + heuristic_cost_estimate(start, goal);
			
			while(openset.length != 0){
				var idx:int = min_f(openset, f_score);
				var current:Vec2 = openset[idx]; // the node in openset having the lowest f_score[] value
				
				if (goal.x == current.x && goal.y == current.y){
					var p:Array = reconstruct_path(came_from, current);
					var path:Path = new Path(start, goal, p);
					return path;
				}
				openset.splice(idx, 1); //remove current from openset
				closedset[current.x][current.y] = 1; //add current to closedset
				var neighbors:Array =  neighbor_nodes(current, curMap);
				for (i = 0; i < neighbors.length; i++){
					var neighbor:Vec2 = neighbors[i];
					var tentative_g_score:Number = g_score[current.x][current.y] + dist_between(current,neighbor);
					var tentative_f_score:Number = tentative_g_score + heuristic_cost_estimate(neighbor, goal)
					if (closedset[neighbor.x][neighbor.y] && tentative_f_score >= f_score[neighbor.x][neighbor.y]){
						continue;
					}
					
					if ((contains(openset, neighbor) == 0)|| tentative_f_score < f_score[neighbor.x][neighbor.y]) {
						came_from[neighbor] = current;
						g_score[neighbor.x][neighbor.y] = tentative_g_score;
						f_score[neighbor.x][neighbor.y] = tentative_f_score;
						if (!contains(openset, neighbor)){
							openset.push(neighbor);
						}
					}
				}
			}
			return null;
			
		}
		
		public static function heuristic_cost_estimate(start:Vec2, goal:Vec2):Number{
		
			return Vec2.diff(start, goal).abs();
		}
		
		public static function reconstruct_path(came_from:Dictionary, current_node:Vec2):Array{
			var p:Array;
			if (came_from[current_node] != null){
				p = reconstruct_path(came_from, came_from[current_node]);
				var c:Vec2 = current_node.copy();
				c.x *= C.TILE_SIZE;
				c.x += C.TILE_SIZE/2;
				c.y *= C.TILE_SIZE;
				c.y += C.TILE_SIZE/2;
				p.push(c);
			}
			else{
				p = new Array();	
				var cp:Vec2 = current_node.copy();
				cp.x *= C.TILE_SIZE;
				cp.y *= C.TILE_SIZE;
				cp.x += C.TILE_SIZE/2;
				cp.y += C.TILE_SIZE/2;
				p.push(cp);
			}
			return p;
				
		}
		
		//as the crow flies for now
		public static function dist_between(current:Vec2, neighbor:Vec2):int{
			return Vec2.diff(current, neighbor).abs();
		}
		
		public static function contains(openset:Array, neighbor:Vec2):int{
			for(var i:int = 0; i < openset.length;i++){
				var n:Vec2 = openset[i];
				if(n.x == neighbor.x && n.y == neighbor.y){
					return 1;
				}
			}
			return 0;
		}
		
		//Refactor this with insertion sort. Currently returns the index of the object with the smallest f_score
		public static function min_f(openset:Array, f_score:Array):int{
			var minValue:int = 10000;
			var open:int = -1;
			for(var i:int = 0 ; i < openset.length; i++){
				var pos:Vec2 = openset[i];
				if (f_score[pos.x][pos.y] < minValue){
				
					minValue = f_score[pos.x][pos.y];
					open = i;
				}
			
			}
			
			return open;
		
		}
		
		public static function neighbor_nodes(c:Vec2, curMap:Object):Array{
			var neighbors:Array = new Array();
			var current:Vec2 = c.copy();
			for (var i:int = -1 + c.x; i < 2 + c.x; i++){
				for (var j:int = -1 + c.y; j < 2 + c.y; j++){
					if(!(i == current.x && j == current.y)){
						if(inGrid(i, j)){
							//not a wall
							if(curMap[i][j] == 0){
								neighbors.push(new Vec2(i, j));
							}
						
						}
					}
					
				}
			
			}
			
			return neighbors;
		
		}
		
		public static function inGrid(i:int, j:int):Boolean{
			return (j >= 0 && j < C.MAP_WIDTH/C.TILE_SIZE && i >= 0 && i < C.MAP_HEIGHT/C.TILE_SIZE);
		}
	}
}	