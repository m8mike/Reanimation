package {
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	/**
	* ...
	* @author Mad Mike
	*/
	public class ChildVisBranch extends ChildVisItem {
		public var plusHide:TextField;
		public var children:Array = [];
		
		public function ChildVisBranch(text:String, location:Point, parent:DisplayObjectContainer, obj:DisplayObjectContainer, index:int) {
			var loc1:Point = location.clone();
			loc1.x += 20;
			textField = createText(text, loc1);
			
			plusHide = createText("-", location);
			plusHide.textColor = 0xFFFFFF;
			addChild(plusHide);
			plusHide.addEventListener(MouseEvent.CLICK, toggleBranch);
			
			addChild(textField);
			parent.addChild(this);
			current = obj;
			textField.addEventListener(MouseEvent.CLICK, toggle);
			super(text, location, parent, obj, index);
		}
		
		private function toggleBranch(e:MouseEvent):void {
			if (plusHide.text == "-") {
				plusHide.text = "+";
				DisplayObjectContainer(current).tabEnabled = true;
			} else {
				plusHide.text = "-";
				DisplayObjectContainer(current).tabEnabled = false;
			}
			Reanimation.thisIs.tree.reload();
		}
		
		public function addKid(kid:ChildVisItem):void {
			children.push(kid);
		}
		
		public static function createText(text:String, loc:Point):TextField {
			var tf:TextField = new TextField();
			tf.x = loc.x;
			tf.y = loc.y;
			tf.visible = true;
			tf.selectable = false;
			tf.text = text;
			var mytf:TextFormat = new TextFormat("Courier New");
			mytf.size = 12;
			tf.setTextFormat(mytf);
			tf.defaultTextFormat = mytf;
			tf.width = 10 + text.length * 7;
			tf.height = 20;
			tf.background = true;
			tf.backgroundColor = 0x000000;
			tf.textColor = 0xFF0000;
			return tf;
		}
	}
}