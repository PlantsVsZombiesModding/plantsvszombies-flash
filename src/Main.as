package
{
	import com.popcap.flash.games.pvz.resources.PVZResources;
	import flash.display.Sprite;
	import flash.events.Event;
	
	import com.popcap.flash.games.pvz.PVZFlash;
	
	/**
	 * ...
	 * @author spaghetto
	 */
	public class Main extends PVZFlash 
	{
		
		[Embed(source = "../bin/resources.swf")]
		public static var mResourceSWF:Class;
		
		public function Main() 
		{
			//mResourceSWF = new 
			if (stage) 
			{
				startup();
				super();
			}
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function startup(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			//init();
		}
		
	}
	
}