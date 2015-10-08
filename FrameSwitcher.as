package {
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.text.TextField;
	
	/**
	* ...
	* @author Mad Mike
	*/
	public class FrameSwitcher {
		private var currentAnimation:MovieClip;
		
		public function FrameSwitcher(animation:MovieClip, parent:DisplayObjectContainer) {
			currentAnimation = animation;
			var playStopTF:TextField = ChildVisBranch.createText("stop", new Point(400, 20));
			var prevTF:TextField = ChildVisBranch.createText("prev", new Point(350, 20));
			var nextTF:TextField = ChildVisBranch.createText("next", new Point(450, 20));
			parent.addChild(playStopTF);
			parent.addChild(prevTF);
			parent.addChild(nextTF);
			playStopTF.addEventListener(MouseEvent.CLICK, playOrStop);
			prevTF.addEventListener(MouseEvent.CLICK, toPrev);
			nextTF.addEventListener(MouseEvent.CLICK, toNext);
		}
		
		private function toNext(e:MouseEvent):void {
			var nextFr:int = currentAnimation.currentFrame + 1;
			if (nextFr > currentAnimation.totalFrames) {
				nextFr = 1;
			}
			trace(nextFr);
			currentAnimation.gotoAndStop(nextFr);
			CharacterAnimation.makeAllChildrenGoToFrame(currentAnimation, nextFr);
		}
		
		private function toPrev(e:MouseEvent):void {
			CharacterAnimation.stopEveryChild(currentAnimation);
			var prevFr:int = currentAnimation.currentFrame - 1;
			if (prevFr <= 0) {
				prevFr = currentAnimation.totalFrames;
			}
			trace(prevFr);
			currentAnimation.gotoAndStop(prevFr);
			CharacterAnimation.makeAllChildrenGoToFrame(currentAnimation, prevFr);
		}
		
		private function playOrStop(e:MouseEvent):void {
			var playStopTF:TextField = TextField(e.target);
			if (playStopTF.text == "play") {
				playStopTF.text = "stop";
				CharacterAnimation.playEveryChild(currentAnimation);
			} else {
				playStopTF.text = "play";
				CharacterAnimation.stopEveryChild(currentAnimation);
			}
					ChildVisTree.change(ChildVisTree.firstBranch);
		}
	
	}

}