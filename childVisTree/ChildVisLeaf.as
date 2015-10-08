package {
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	/**
	* ...
	* @author Mad Mike
	*/
	public class ChildVisLeaf extends ChildVisItem {
		
		public function ChildVisLeaf(text:String, location:Point, parent:DisplayObjectContainer, obj:DisplayObject, index:int) {
			textField = ChildVisBranch.createText(text, location);
			addChild(textField);
			parent.addChild(this);
			current = obj;
			textField.addEventListener(MouseEvent.CLICK, toggle);
			super(text, location, parent, obj, index);
		}
		
	}
}