package
{
	import com.Ball;
	
	import flash.Boot;
	import flash.display.*;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;
	
	import mx.core.mx_internal;
	
	import nape.geom.*;
	import nape.phys.*;
	import nape.shape.*;
	import nape.space.*;
	import nape.util.*;
	
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.EnterFrameEvent;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	import starling.textures.RenderTexture;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	import utils.XORRandom;
	
	public class Game extends Sprite
	{
		[Embed(source = "../media/textures/background.jpg")]
		private const backgroundTexture:Class;
		
		[Embed(source = "../media/textures/point2.png")]
		private const pointDraw:Class;
		
		public var space:Space = new Space(new Vec2(0, 200)); // Мир
		
		private var mRenderTexture:RenderTexture;
		private var mBrush:Image;
		
		private var text:TextField;
		
		private var shot:Timer=new Timer(150,2800);
		
		private var nativeStage : Stage;
		
		public static var GAME:Game;
		
		public function Game():void
		{
			if(!GAME)GAME=this;
			
			//new Boot();
			
			nativeStage = Starling.current.nativeStage;
						
			var bg:Texture = Texture.fromBitmap(new backgroundTexture());
			var background:Image = new Image(bg);
			background.width=Main.stageWidth;
			background.height=Main.stageHeight;
			this.addChild(background as starling.display.DisplayObject);
			
			var ground:Body = new Body(BodyType.STATIC); // Низ
			ground.shapes.add(new Polygon(Polygon.rect(0, 1676*Main.yResize, Main.stageWidth, Main.stageHeight), Material.rubber()));
			ground.space = space;
			
			var ground2:Body = new Body(BodyType.STATIC); // Лево
			ground2.shapes.add(new Polygon(Polygon.rect(0, 0, 65*Main.xResize, 1920*Main.yResize), Material.rubber()));
			ground2.space = space;
			
			var ground3:Body = new Body(BodyType.STATIC); // Право
			ground3.shapes.add(new Polygon(Polygon.rect(1015*Main.xResize, 0, 0, 1920*Main.yResize), Material.rubber()));
			ground3.space = space;
			
			
			//текст
			text=new TextField(Main.stageWidth,40,"БАЛЛЫ","Verdana",32,0xFFFFFF,false);
			text.y=Main.yResize*1750;
			this.addChild(text);
			
			//space.bodies.at(
			
			
			
			addEventListener(EnterFrameEvent.ENTER_FRAME, enterFrame);
			
			shot.addEventListener(TimerEvent.TIMER,startShot);
			shot.start();
			
			nativeStage.addEventListener( MouseEvent.CLICK,mClick);
			
			
			
			//this.addEventListener(TouchEvent.TOUCH,clickBall);
			
			//addDraw();
		}
		
		private function mClick(event:MouseEvent):void
		{
			var mousePoint : Vec2 = new Vec2( event.stageX, event.stageY );
			var bodies : BodyList = space.bodiesUnderPoint( mousePoint );
			
			
//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!СПИСОК ТЕЛ ВНУТРИ КРУГА!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
			//space.bodiesInCircle();
			
			if(bodies.length>0)
			{
				var body:Body=bodies.shift();
				if(body.graphic as Ball)
				{
					text.text=String(body.id);
				}
			}
			

			
		}
		

		
		private function startShot(event:TimerEvent):void
		{
			var ball:Ball=new Ball();
			ball.add(this,space);
		}
		
		private function enterFrame(e:Event):void 
		{
			space.step(1 / 30.0);
			
						
			
			/*var i:uint = balls.length;
			//text.text=String(i);
			while ( --i > -1)
			{
				balls[i].sincBall();
				
				if(balls[i].x<0 || balls[i].x> Main.stageWidth)
				{
					space.bodies.remove(balls[i].body);
					this.removeChild(balls[i]);
					balls.splice(i,1);					
				}
				
				
			}	*/		
			
			
			
		}
		
		public function stopGame():void
		{
			//space.bodies.clear();
			//this.removeChildren();
		}
	}
}