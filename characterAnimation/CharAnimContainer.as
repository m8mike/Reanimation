package {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.getQualifiedClassName;
	
	/**
	* ...
	* @author Mad Mike
	*/
	public class CharAnimContainer {
		private var cachedShoes1:Array = [];
		private var cachedHands1:Array = [];
		private var cachedRocket1:Bitmap;
		private var cachedHeadsRight:Array = [];
		private var cachedHeadsLeft:Array = [];
		private var cachedHats:Array = [];
		private var cachedStripes:Array = [];
		private var cachedRocket2:Bitmap;
		private var cachedShoes2:Array = [];
		private var cachedHands2:Array = [];
		
		public static var mc:MovieClip;
		
		public function CharAnimContainer(anim:MovieClip) {
			mc = anim;
			for (var i:int = 1; i <= mc.totalFrames; i++) {
				CharacterAnimation.makeAllChildrenGoToFrame(mc, i);
				var shoes1:Array = [];
				var hands1:Array = [];
				var shoes2:Array = [];
				var hands2:Array = [];
				isolateChildren(getChildFrom(mc, [0, 0]), shoes1); //shoes
				isolateChildren(getChildFrom(mc, [0, 1]), hands1); //hands
				cachedRocket1 = CharacterAnimation.convertToBitmap(MovieClip(getChildFrom(mc, [0, 2]))); //rocket
				parseHead(getChildFrom(mc, [0, 3, 0])); //heads/hats/stripes
				cachedRocket2 = CharacterAnimation.convertToBitmap(MovieClip(getChildFrom(mc, [0, 4]))); //rocket
				isolateChildren(getChildFrom(mc, [0, 5]), shoes2); //shoes
				isolateChildren(getChildFrom(mc, [0, 6]), hands2); //hands
				cachedShoes1.push(shoes1);
				cachedHands1.push(hands1);
				cachedShoes2.push(shoes2);
				cachedHands2.push(hands2);
			}
		}
		
		public static function mergeBitmapDatas(destination:BitmapData, source:BitmapData):void {
			var bounds:Rectangle = new Rectangle(0, 0, destination.width, destination.height);
			destination.copyPixels(source, bounds, new Point(), source, new Point(), true);
		}
		
		public function getBitmap(config:AnimConfig, frame:int):Bitmap {
			var rect:Rectangle = mc.getBounds(mc);
			var bitmapData:BitmapData = new BitmapData(rect.width, rect.height, true, 0x00000000);
			mergeBitmapDatas(bitmapData, cachedShoes1[frame-1][config.shoes1ID].bitmapData);
			mergeBitmapDatas(bitmapData, cachedHands1[frame-1][config.hands1ID].bitmapData);
			mergeBitmapDatas(bitmapData, cachedRocket1.bitmapData);
			if (config.left) {
				mergeBitmapDatas(bitmapData, cachedHeadsLeft[frame-1][config.headID].bitmapData);
			} else {
				mergeBitmapDatas(bitmapData, cachedHeadsRight[frame-1][config.headID].bitmapData);
			}
			mergeBitmapDatas(bitmapData, cachedHats[frame-1][config.hatID].bitmapData);
			if (config.stripeID != -1) {
				mergeBitmapDatas(bitmapData, cachedStripes[frame-1][config.stripeID].bitmapData);
			}
			mergeBitmapDatas(bitmapData, cachedRocket2.bitmapData);
			mergeBitmapDatas(bitmapData, cachedShoes2[frame-1][config.shoes2ID].bitmapData);
			mergeBitmapDatas(bitmapData, cachedHands2[frame-1][config.hands2ID].bitmapData);
			var bitmap:Bitmap = new Bitmap(bitmapData);
			return bitmap;
		}
		
		private function parseHead(doc:DisplayObjectContainer):void {
			var hats:Array = [];
			var stripes:Array = [];
			var headsLeft:Array = [];
			var headsRight:Array = [];
			for (var i:int = 0; i < doc.numChildren; i++) {
				hideNeighbours(doc);
				hideNeighbours(doc.getChildAt(i));
				var child:DisplayObject = doc.getChildAt(i);
				if (getQualifiedClassName(child).search("hat") != -1) {
					hats.push(CharacterAnimation.convertToBitmap(MovieClip(child)));
				} else if (getQualifiedClassName(child).search("stripe") != -1) {
					stripes.push(CharacterAnimation.convertToBitmap(MovieClip(child)));
				} else if (i % 2) {
					headsLeft.push(CharacterAnimation.convertToBitmap(MovieClip(child)));
				} else {
					headsRight.push(CharacterAnimation.convertToBitmap(MovieClip(child)));
				}
			}
			cachedHats.push(hats);
			cachedStripes.push(stripes);
			cachedHeadsLeft.push(headsLeft);
			cachedHeadsRight.push(headsRight);
		}
		
		private function getChildFrom(doc:DisplayObjectContainer, a:Array):DisplayObjectContainer {
			var child:DisplayObjectContainer = doc;
			for each (var id:int in a) {
				for (var j:int = 0; j < child.numChildren; j++) {
					if (id != j) {
						child.getChildAt(j).visible = false;
					}
				}
				child = DisplayObjectContainer(child.getChildAt(id));
				child.visible = true;
			}
			return child;
		}
		
		private function hideNeighbours(doc:DisplayObject):void {
			for (var k:int = 0; k < doc.parent.numChildren; k++) {
				doc.parent.getChildAt(k).visible = false;
			}
			doc.visible = true;
		}
		
		private function isolateChildren(doc:DisplayObjectContainer, room:Array):void {
			for (var i:int = 0; i < doc.numChildren; i++) {
				hideNeighbours(doc);
				hideNeighbours(doc.getChildAt(i));
				room.push(CharacterAnimation.convertToBitmap(MovieClip(doc.getChildAt(i))));
			}
		}
	}
}