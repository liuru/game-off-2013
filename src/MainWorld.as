package
{
	import lit.*;
	
	import net.flashpunk.FP;
	import net.flashpunk.World;
	import net.flashpunk.graphics.Image;
	
	public class MainWorld extends World
	{
		public var map:Array = new Array(C.MAP_TILE_WIDTH, C.MAP_TILE_HEIGHT);
		internal var civilians:Array = [];
		internal var enemies:Array = [];
		internal var player:Player;
		internal var counter:int = 0;
	
		
		public var lighting:Lighting;
		public var playerLight:Light;
		
		public function MainWorld()
		{
			FP.console.enable();
			

			
			add(lighting = new Lighting(FP.screen.width, FP.screen.height));
			lighting.add(playerLight = new Light(0, 0, C.SPR_LIGHT_CIRCLE_GRADIENT_IMG, 2, 0.8));
			
			player = new Player();
		
			add(player);
			
			for(var i:int = 0; i < 2; i++){
				enemies.push(this.add(new Enemy()));
			}
			for(i = 0; i < 9; i++){
				var civ:Civilian = new Civilian();
				lighting.add(civ.light);
				civilians.push(this.add(civ));
			}
			
			var lvl:Object = LevelLoader.getLevel1();
			
			for(var x: int = 0; x < 20; x++ ) 
			for(var y: int = 0; y < 16; y++ ) {
				
				if(lvl.map[y][x] > 0) {
					add(new Wall(x*C.TILE_SIZE, y*C.TILE_SIZE));
				}
			}
			AStar.search(new Vec2(120, 50), new Vec2(0, 0));
		}
		
		
		override public function update():void
		{
			super.update();
			
			counter++;
			var playerP:Vec2 = new Vec2(player.x, player.y);
			for each(var c:Civilian in civilians){
				if(player.singing == 0){
					c.decreaseAttention();
				}
				else {
					var loc:Vec2 = new Vec2(c.x, c.y);
					var diff:Vec2 = Vec2.diff(playerP, loc);
					
					if(diff.abs() > C.HEARING_RADIUS|| c.happy_points > C.HAPPY_METER_MAX){
						c.decreaseAttention();
					}
					else{
						if(c.happy_points <= C.HAPPY_METER_MAX){
							c.chargeAttention(playerP, player);
						}
					}
				}
			}
			
			
			for each(var e:Enemy in enemies){	
				if(player.singing == 0){
					e.decreaseAttention();
				}
				else{
					loc = new Vec2(e.x, e.y);
					diff = Vec2.diff(playerP, loc);
					
					if(diff.abs() > C.HEARING_RADIUS){
						e.decreaseAttention();
					}
					else{
						e.chargeAttention(playerP, player);
					}
				}	
			}
			
			playerLight.x = player.x;
			playerLight.y = player.y;
		 
		}
	}
}