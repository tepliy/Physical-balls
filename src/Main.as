package
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	
	import starling.core.Starling;
	
	import utils.Stats;
	
	[SWF(frameRate="60", backgroundColor="#000000")]
	public class Main extends Sprite
	{
		private var mStarling:Starling;
		
		public static var stageWidth:Number;
		public static var stageHeight:Number;
		public static var xResize:Number;
		public static var yResize:Number;
		
		public function Main()
		{
			if(stage)init();
			else addEventListener(Event.ADDED_TO_STAGE,init);
		}
		
		public function init(event:Event=null):void
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			Starling.multitouchEnabled = true;
			mStarling = new Starling(Game, stage,stage.fullScreenSourceRect);
			mStarling.simulateMultitouch = true;
			mStarling.enableErrorChecking = false;
			mStarling.start();
			
			stageHeight=stage.fullScreenHeight;
			stageWidth=stage.fullScreenWidth;
			xResize=stageWidth/1080;
			yResize=stageHeight/1920;
			
			var stat:Stats=new Stats();
			
			stat.x=xResize*65;
			stat.y=yResize*1676;
			
			addChild(stat);
			
			//addChild(new Stats());
		}
	}
}