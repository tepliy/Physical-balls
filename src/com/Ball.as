package com
{
	import flash.display.Stage;
	
	import nape.geom.Vec2;
	import nape.phys.Body;
	import nape.phys.BodyType;
	import nape.phys.Material;
	import nape.shape.Circle;
	import nape.space.Space;
	
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	import utils.XORRandom;
	
	public class Ball extends Sprite
	{
		public var body:Body;
		
		private var diameter:Number;
		public var id:int;
		public var idPhys:int;
		
		[Embed(source = "../media/textures/ball.png")]
		private const ballTexture:Class;
		[Embed(source = "../media/textures/ball.xml", mimeType = "application/octet-stream")]
		private const ballAtlas:Class;		
		
		private var atlas:TextureAtlas;
		
		public function Ball()
		{
			var textureBall:Texture = Texture.fromBitmap(new ballTexture());
			
			var xml:XML = XML(new ballAtlas());
			atlas = new TextureAtlas(textureBall, xml);
			id=XORRandom.randomRangeInt(1,6);
			//super(atlas.getTexture(String(id)));
			
			var im:Image = new Image(atlas.getTexture(String(id)));
			im.width=im.height=diameter=160*Main.yResize;
			addChild(im);
			body = new Body(BodyType.DYNAMIC, new Vec2(XORRandom.randomRangeInt(40, Main.stageWidth-100), -50)); 
			body.shapes.add(new Circle(diameter/2, new Vec2(0, 0), Material.wood()));
			//body.id;    //cbType=CbType.get();
			body.align();
			
			this.pivotX = this.width >> 1;
			this.pivotY = this.height >> 1;

		}

		
		public function add(parents:Sprite,space:Space):void
		{
			body.space=space;
			body.graphic=this;
			body.graphicUpdate = _updateGraphic;
			parents.addChild(this);
			idPhys=body.id;
			
			
			var text:TextField=new TextField(60,60,String(idPhys),"Verdana",20,0x000000,false);
			
			//addChild(text);
		}
				
		private function _updateGraphic(b:Body):void
		{
			var gr:DisplayObject = b.graphic;
			gr.x = b.position.x;
			gr.y = b.position.y;
			
			//var ba:Ball=b.graphic as Ball;
			//trace(ba.idPhys);

			
			
			if(b.position.x<0 || b.position.x>Main.stageWidth)Game.GAME.stopGame();
			
		}
		
	}
}