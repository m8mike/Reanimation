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
	public class ChildVisItem extends MovieClip {
		public var textField:TextField;
		protected var current:DisplayObject;
		public var path:Array = [];
		
		public function ChildVisItem(text:String, location:Point, parent:DisplayObjectContainer, obj:DisplayObject, index:int) {
			if (parent is ChildVisBranch) {
				var branchParent:ChildVisBranch = ChildVisBranch(parent);
				branchParent.addKid(this);
				for (var i:int = 0; i < branchParent.path.length; i++) {
					path.push(branchParent.path[i]);
				}
				path.push(index);
			}
		}
		
		protected function toggle(e:MouseEvent):void {
			if (e.ctrlKey) {
				if (checkStar()) {
					textField.text = textField.text.substr(0, textField.text.length - 1);
				} else {
					textField.appendText("*");
				}
			} else {
				if (current.visible) {
					unselect();
				} else {
					select();
				}
			}
		}
		
		public function checkStar():Boolean {
			if (textField.text.charAt(textField.text.length - 1) == "*") {
				return true;
			}
			return false;
		}
		
		public function select():void {
			textField.textColor = 0xFF0000;
			current.visible = true;
		}
		
		public function unselect():void {
			textField.textColor = 0xFFFFFF;
			current.visible = false;
		}
	}
}