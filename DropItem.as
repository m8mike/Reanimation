package {
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	/**
	* ...
	* @author Mad Mike
	*/
	public class DropItem extends MovieClip {
		private var textField:TextField;
		private var location:Point;
		
		public function DropItem(text:String, location:Point, parent:DisplayObjectContainer) {
			this.location = location.clone();
			textField = new TextField();
			textField.x = location.x;
			textField.y = location.y;
			textField.visible = true;
			textField.selectable = false;
			textField.text = text;
			var mytf:TextFormat = new TextFormat("Courier New");
			mytf.size = 12;
			textField.setTextFormat(mytf);
			textField.defaultTextFormat = mytf;
			textField.width = 10 + text.length * 7;
			textField.height = 20;
			textField.background = true;
			textField.backgroundColor = 0x000000;
			textField.alpha = 0.9;
			textField.textColor = 0xFF0000;
			addChild(textField);
			parent.addChild(this);
		}
		
		public function getText():String {
			return textField.text;
		}
		
		public function select(loc:Point):void {
			textField.x = loc.x;
			textField.y = loc.y;
			textField.textColor = 0xFFFFFF;
		}
		
		public function unselect():void {
			textField.x = location.x;
			textField.y = location.y;
		}
		
		public function remove():void {
			textField.parent.removeChild(textField);
		}
	}
}