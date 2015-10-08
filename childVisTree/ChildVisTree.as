package {
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.text.TextField;
	
	/**
	* ...
	* @author Mad Mike
	*/
	public class ChildVisTree extends MovieClip {
		public static var docRoot:DisplayObjectContainer;
		public static var numBranches:int = 0;
		private static var offsetX:int = 0;
		private static var layer:MovieClip;
		public static var firstBranch:ChildVisBranch;
		
		public function ChildVisTree(doc:DisplayObjectContainer, parent:DisplayObjectContainer) {
			docRoot = doc;
			layer = new MovieClip();
			parent.addChild(layer);
			addBranches(DisplayObjectContainer(doc), layer, 0);
		}
		
		public function addBranches(doc:DisplayObjectContainer, parent:DisplayObjectContainer, index:int):void {
			var branch:ChildVisBranch = new ChildVisBranch(doc.toString(), new Point(offsetX * 40, numBranches * 20), parent, doc, index);
			if (!firstBranch) {
				firstBranch = branch;
			}
			numBranches++;
			if (!doc.visible) {
				branch.textField.textColor = 0xFFFFFF;
			}
			if (doc.tabEnabled) {
				branch.plusHide.text = "+";
				return void;
			}
			for (var i:int = 0; i < doc.numChildren; i++) {
				var child:DisplayObject = doc.getChildAt(i);
				if (child is DisplayObjectContainer) {
					offsetX++;
					addBranches(DisplayObjectContainer(child), branch, i);
					offsetX--;
				} else {
					offsetX++;
					var leaf:ChildVisLeaf = new ChildVisLeaf(child.toString(), new Point(offsetX * 40, numBranches * 20), parent, child, index);
					if (!child.visible) {
						leaf.textField.textColor = 0xFFFFFF;
					}
					numBranches++;
					offsetX--;
				}
			}
		}
		
		public static function change(branch:ChildVisBranch):void {
			for each (var child:ChildVisItem in branch.children) {
				if (child.checkStar()) {
					trace(child.path);
					//Reanimation.hideAll(MovieClip(docRoot));
					//show(child.path);
				}
				if (child is ChildVisBranch) {
					change(ChildVisBranch(child));
				}
			}
		}
		
		public function reload():void {
			while (layer.numChildren) {
				layer.removeChildAt(0);
			}
			numBranches = 0;
			offsetX = 0;
			addBranches(docRoot, layer, 0);
		}
		
		public static function showAll(doc:DisplayObjectContainer):void {
			for (var i:int = 0; i < doc.numChildren; i++) {
				var child:DisplayObject = doc.getChildAt(i);
				child.visible = true;
				if (child is DisplayObjectContainer) {
					showAll(DisplayObjectContainer(child));
				}
			}
			MovieClip(docRoot).play();
		}
		
		public static function show(path:Array):void {
			var displayObject:DisplayObject = docRoot;
			displayObject.visible = true;
			for (var i:int = 0; i < path.length; i++) {
				displayObject = DisplayObjectContainer(displayObject).getChildAt(path[i]);
				displayObject.visible = true;
			}
			if (displayObject is DisplayObjectContainer) {
				showAll(DisplayObjectContainer(displayObject));
			}
		}
	}
}