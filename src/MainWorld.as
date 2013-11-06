package
{
	import net.flashpunk.World;
	
	public class MainWorld extends World
	{
		public function MainWorld()
		{
			super();
			
			add(new Player());
			
			add(new Enemy());
			add(new Enemy());
			add(new Enemy());
			add(new Enemy());
			add(new Enemy());
			
			add(new Civilian());
			add(new Civilian());
			add(new Civilian());
			add(new Civilian());
			add(new Civilian());
			
		}
		
		
	}
}