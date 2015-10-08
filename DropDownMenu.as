package {
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	/**
	* ...
	* @author Mad Mike
	*/
	public class DropDownMenu extends MovieClip {
		private var items:Array = [];
		private var location:Point;
		public var selectedItem:DropItem;
		private var onSelect:Function;
		
		public function DropDownMenu(loc:Point, parent:DisplayObjectContainer, callback:Function = null) {
			onSelect = callback;
			location = loc;
			parent.addChild(this);
			addEventListener(MouseEvent.CLICK, dropDown);
		}
		
		public function pushItem(text:String) {
			var loc:Point = new Point(location.x, location.y + items.length * 20);
			var item:DropItem = new DropItem(text, loc, this);
			if (items.length == 0) {
				selectedItem = item;
			} else {
				item.visible = false;
			}
			items.push(item);
		}
		
		private function dropDown(e:MouseEvent):void {
			selectedItem.unselect();
			removeEventListener(MouseEvent.CLICK, dropDown);
			addEventListener(MouseEvent.ROLL_OUT, rollOut);
			addEventListener(MouseEvent.CLICK, select);
			setVisible(true);
		}
		
		private function setVisible(vis:Boolean):void {
			for each (var item:DropItem in items) {
				if (selectedItem != item) {
					item.visible = vis;
				}
			}
		}
		
		private function show():void {
		}
		
		private function select(e:MouseEvent):void {
			selectedItem = DropItem(DisplayObject(e.target).parent);
			selectedItem.select(location);
			setVisible(false);
			removeEventListener(MouseEvent.ROLL_OUT, rollOut);
			removeEventListener(MouseEvent.CLICK, select);
			addEventListener(MouseEvent.CLICK, dropDown);
			if (onSelect != null) {
				onSelect();
			}
		}
		
		private function rollOut(e:MouseEvent):void {
			selectedItem.select(location);
			setVisible(false);
			removeEventListener(MouseEvent.ROLL_OUT, rollOut);
			removeEventListener(MouseEvent.CLICK, select);
			addEventListener(MouseEvent.CLICK, dropDown);
		}
		
		public function remove():void {
			for each (var item:DropItem in items) {
				item.remove();
				items.splice(items.indexOf(item), 1);
			}
			if (this.hasEventListener(MouseEvent.ROLL_OUT)) {
				removeEventListener(MouseEvent.ROLL_OUT, rollOut);
				removeEventListener(MouseEvent.CLICK, select);
			} else if (hasEventListener(MouseEvent.CLICK)) {
				removeEventListener(MouseEvent.CLICK, dropDown);
			}
		}
	}
}