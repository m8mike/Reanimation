package {
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	/**
	* ...
	* @author Mad Mike
	*/
	public class Reanimation extends MovieClip {
		private var costume:Bitmap;
		public static var frameCounter = 1;
		private var goAnim:CharAnimContainer;
		private var animConfig:AnimConfig;
		
		public var currentAnimation:MovieClip;
		public static var thisIs:Reanimation;
		public var tree:ChildVisTree;
		public var frameSwitcher:FrameSwitcher;
		public var animSelect:DropDownMenu;
		
		public function Reanimation() {
			thisIs = this;
			var scroller:Scroller = new Scroller();
			currentAnimation = new go_left();
			currentAnimation.x = 400;
			currentAnimation.y = 200;
			//addChild(currentAnimation);
			//tree = new ChildVisTree(currentAnimation, scroller);
			frameSwitcher = new FrameSwitcher(currentAnimation, this);
			animSelect = new DropDownMenu(new Point(20, 20), this, changeAnimation);
			animSelect.pushItem("go_right");
			animSelect.pushItem("go_left");
			animSelect.pushItem("fall_right");
			animSelect.pushItem("fall_left");
			animSelect.pushItem("jump_right");
			animSelect.pushItem("jump_left");
			animSelect.pushItem("stay_right");
			animSelect.pushItem("stay_left");
			animSelect.pushItem("umbrella_right");
			animSelect.pushItem("umbrella_left");
			animSelect.pushItem("walljump_right");
			animSelect.pushItem("walljump_left");
			goAnim = new CharAnimContainer(currentAnimation);
			animConfig = new AnimConfig();
			costume = goAnim.getBitmap(animConfig, frameCounter);
			addChild(costume);
			addEventListener(Event.ENTER_FRAME, update);
		}
		
		private function update(e:Event):void {
			if (frameCounter == currentAnimation.totalFrames) {
				frameCounter = 1;
			} else {
				frameCounter++;
			}
			removeChild(costume);
			costume.bitmapData.dispose();
			if (frameCounter == 1) {
				animConfig.hatID = int(Math.random() * 15);
				animConfig.shoes1ID = int(Math.random() * 3);
				animConfig.shoes2ID = animConfig.shoes1ID;
				animConfig.headID = int(Math.random() * 4);
			}
			costume = goAnim.getBitmap(animConfig, frameCounter);
			addChild(costume);
		}
		
		public function changeAnimation():void {
			currentAnimation = new (getDefinitionByName(animSelect.selectedItem.getText()))();
			currentAnimation.x = 400;
			currentAnimation.y = 200;
		}
	}
}