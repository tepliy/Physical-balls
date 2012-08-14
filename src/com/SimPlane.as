/**
 * Created by IntelliJ IDEA.
 * User: ponomarev
 * Date: 31.08.2011
 * Time: 09:50
 * To change this template use File | Settings | File Templates.
 */
package com
{
	import alternativa.engine3d.materials.TextureMaterial;
	import alternativa.engine3d.resources.BitmapTextureResource;
	import alternativa.physics3dintegration.StaticObject;
	import alternativa.physics3dintegration.VertexLightMaterial;
	import alternativa.physics3dintegration.utils.MeshUtils;
	import alternativa.physicsengine.geometry.collision.CollisionType;
	import alternativa.physicsengine.geometry.collision.primitives.CollisionBox;
	import alternativa.physicsengine.geometry.collision.primitives.CollisionRect;
	import alternativa.physicsengine.math.Matrix4;
	import alternativa.physicsengine.math.Vector3;
	import alternativa.physicsengine.physics.types.PhysicsPrimitive;
	
	import flash.display.Stage3D;

	/**
     * EN:
     * Plane class. It creates physical and graphical components. Similarly, the hello_world lesson.
     *
	 * RU:
     * Объект плоскость. Создается физическая и графическая составляющая. Аналогично уроку hello_world.
	 */
	public class SimPlane extends StaticObject {
		
		[Embed(source="../media/textures/background.jpg")] private static const EmbedTexture:Class;
		
		public function SimPlane(width:int, height:int) {
			super();
            // EN: Add a physical primitive with standart material and geometry of rectangle.
			// RU: Добавление физического примитива стандартного материала с геометрией прямоугольника.
			addPhysicsPrimitive(
					new PhysicsPrimitive(new CollisionBox(new Vector3(width, height,10), CollisionType.STATIC))
			);
			// Texture
			// Установка текстуры
			var material:TextureMaterial = new TextureMaterial();
			material.diffuseMap = new BitmapTextureResource(new EmbedTexture().bitmapData);
			//material.diffuseMap.upload(Stage3D.context3);
			
            // EN: Add a graphical represenation of plane.
			// RU: Добавляем графическое изображение прямоугольника.
			addAppearanceComponent(
					MeshUtils.createRectangle(width, height, material)
			);
		}
	}
}
