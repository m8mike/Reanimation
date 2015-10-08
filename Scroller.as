package {
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	/**
	* ...
	* @author Mad Mike
	*/
	public class Scroller extends MovieClip {
		
		public function Scroller() {
			var stage:Stage = Reanimation.thisIs.stage;
			Reanimation.thisIs.addChild(this);
			stage.addEventListener(MouseEvent.MOUSE_WHEEL, wheel);
		}
		
		private function wheel(e:MouseEvent):void {
			if (e.delta > 0 && y > 0) {
				return void;
			}
			if (e.delta < 0 && y < -ChildVisTree.numBranches * 20 + 400) {
				return void;
			}
			y += e.delta;
		}
	}
}