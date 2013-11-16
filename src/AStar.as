package
{
	import flash.utils.Dictionary;

	public class AStar
	{
		private var curMap;
		public function AStar()
		{
			this.curMap = Level.getLevel1().map;	
		}
		
		public void function search(start:Vec2, goal:Vec2):Vec2{
		
			var closedset:Array = new Array(curMap.length); // The set of nodes already evaluated.
			var g_score:Array = [[],[]]; // The set of nodes already evaluated.
			var f_score:Array = [[],[]];
			
			for(var i=0; i<curMap[0].length; i++) {  
				closedset[i] = new Array(curMap[0].length);
				g_score[i] = new Array(curMap[0].length);
				f_score[i] = new Array(curMap[0].length);
				for(var j=0; j<curMap[0]; j++) {   
					closedset[i][j] = 0;
					g_score[i][j] = 0;
					f_score[i][j] = 0;
				} 
				
			}

			
			var openset:Array = new Array(start);    // The set of tentative nodes to be evaluated, initially containing the start node
			var came_from:Dictionay := new Dictionary;    // The map of navigated nodes.
			
			g_score[start.x][start.y] = 0    // Cost from start along best known path.
			// Estimated total cost from start to goal through y.
			f_score[start.x][start.y] = [start.x][start.y] + heuristic_cost_estimate(start, goal);
			
			while(openset.length != 0){
				var idx:int = min_f(openset, f_score);
				var current:Vec2 = openset[idx]; // the node in openset having the lowest f_score[] value
				
				if (goal.x == current.x && goal.y == current.y){
					return reconstruct_path(came_from, goal);
				}
				openset.splice(idx, 1); //remove current from openset
				closedset[current.x][current.y] = 1; //add current to closedset
				for (var neighbor:Vec2 in neighbor_nodes(current)){
					var tentative_g_score:int = g_score[current.x][current.y] + dist_between(current,neighbor);
					var tentative_f_score:int = tentative_g_score + heuristic_cost_estimate(neighbor, goal)
					if (closedset[neighbor.x][neighbor.y] && tentative_f_score >= f_score[neighbor.x][neighbor.y]){
						continue;
					}
					
					if ((contains(openset, neighbor) == 0)|| tentative_f_score < f_score[neighbor.x][neighbor.y]) {
						came_from[neighbor] = current;
						g_score[neighbor.x][neighbor.y] = tentative_g_score;
						f_score[neighbor.x][neighbor.y] = tentative_f_score;
						if (contains(openset, neighbor)){
							openset.push(neighbor);
						}
					}
				}
				return null;
			}
			
		}
		
		public function heuristic_cost_estimate(start:Vec2, goal:Vec2):Vec2{
		
			return (goal.x - start.x)*(goal.x - start.x) + (goal.y - start.y)*(goal.y - start.y);
		}
		
		public function reconstruct_path(came_from:Dictionary, current_node):Array{
			if (came_from[current_node] != null){
				var p:Array = reconstruct_path(came_from, came_from[current_node])
				p.push(current_node);
				return p;
			}
			else{
				var p:Array = new Array();	
				p.push(current_node);
				return p;
			}
			}
		}
		//as the crow flies for now
		public function dist_between(current,neighbor):int{
			return Math.sqrt((current.x - neighbor.x)*(current.x - neighbor.x) + (current.y - neighbor.y)*(current.y - neighbor.y));
		}
		
		public function contains(openset:Array, neighbor:Vec2):int{
			for(var n:Vec2 in openset){
				if(n.x == neighbor.x && n.y == neighbor.y){
					return 1;
				}
			}
			return 0;
		}
		
		//Refactor this with insertion sort. Currently returns the index of the object with the smallest f_score
		public function min_f(openset:Array, f_score:Array):int{
			var minValue = Infinity;
			var open:int = -1;
			for(var i = 0 ; i < openset.length; i++){
				var pos = openset[i];
				if (f_score[pos.x][pos.y] < minValue){
				
					minValue = f_score[pos.x][pos.y];
					open = i;
				}
			
			}
			
			return i;
		
		}
		
		public function neighbor_nodes(current:Vec2):Array{
			var neighbors:Array = new Array();
			
			for (var i = -1; i < 2; i++){
				for (var j = -1; j < 2; j++){
					if(i != current.x && j != current.y){
						if(inGrid(i, j)){
							if(this.curMap[i][j] == null){
								neighbors.add(new Vec2(i, j));
							}
						}
					}
					
				}
			
			}
			
			return neighbors;
		
		}
		
		public function inGrid(i, j){
			return (i >= 0 && i < C.MAP_TILE_WIDTH && j > 0 && j < C.MAP_TILE_HEIGHT);
		}
	}
}