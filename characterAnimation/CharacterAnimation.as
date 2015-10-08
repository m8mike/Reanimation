package {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	/**
	* ...
	* @author Mad Mike
	*/
	public class CharacterAnimation {
		
		public function CharacterAnimation() {
		
		}
		
		/*private static function cropBitmap(bmd:BitmapData, newWidth:uint, newHeight:uint, newX:uint = 0, newY:uint = 0):BitmapData {
			var newBMD:BitmapData = new BitmapData(newWidth, newHeight);
			newBMD.copyPixels(bmd, new Rectangle(newX, newY, newWidth, newHeight), new Point(0, 0));
			return newBMD;
		}
		*/
		public static function convertToBitmap(clip:MovieClip, scaleRate:Number = 1):Bitmap {
			var clipBounds2:Rectangle = CharAnimContainer.mc.getBounds(clip);
			var clipBounds:Rectangle = CharAnimContainer.mc.getBounds(CharAnimContainer.mc);
			var clipBounds1:Rectangle = clip.getBounds(CharAnimContainer.mc);
			var clipBounds3:Rectangle = clip.getBounds(clip);
			var bitmapData:BitmapData = new BitmapData(clipBounds.width, clipBounds.height, true, 0x00000000);
			var matrix:Matrix = new Matrix();
			matrix.translate(clipBounds.width/2, clipBounds.height/2);
			matrix.scale(scaleRate, scaleRate);
			bitmapData.draw(CharAnimContainer.mc, matrix);
			//bitmapData.draw(CharAnimContainer.mc);
			var bitmap:Bitmap = new Bitmap(bitmapData);
			bitmap.scaleX = 1 / scaleRate;
			bitmap.scaleY = 1 / scaleRate;
			return bitmap;
		}
		
		public static function stopEveryChild(m:MovieClip):void {
			for (var i:int = 0; i < m.numChildren; i++) {
				if (m.getChildAt(i) is MovieClip) {
					var c:MovieClip = MovieClip(m.getChildAt(i));
					stopEveryChild(c);
					c.stop();
				}
			}
		}
		
		public static function playEveryChild(m:MovieClip):void {
			for (var i:int = 0; i < m.numChildren; i++) {
				var c = m.getChildAt(i);
				if (c is MovieClip) {
					playEveryChild(c);
					c.play();
				}
			}
		}
		
		public static function setVisEveryFrame(mc:MovieClip, childID:int, vis:Boolean):void {
			for (var i:int = 0; i < mc.totalFrames; i++) {
				mc.gotoAndStop(i);
				mc.getChildAt(childID).visible = vis;
			}
		}
		
		public static function hideAll(m:MovieClip):void {
			m.visible = false;
			for (var i:int = 0; i < m.numChildren; i++) {
				//m.getChildAt(i).visible = false;
				setVisEveryFrame(m, i, false);
				if (m.getChildAt(i) is MovieClip) {
					hideAll(MovieClip(m.getChildAt(i)));
				}
			}
		}
		
		public static function makeAllChildrenGoToFrame(doc:DisplayObjectContainer, f:int):void {
			for (var i:int = 0; i < doc.numChildren; i++) {
				var c = doc.getChildAt(i);
				if (c is MovieClip) {
					makeAllChildrenGoToFrame(c, f);
					c.gotoAndStop(f);
				} else if (c is DisplayObjectContainer) {
					makeAllChildrenGoToFrame(c, f);
				}
			}
		}
	}
}