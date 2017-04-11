this.okBtn.onRelease = function () {
	gotoAndPlay("INTRO", 1);
}
this.okBtn.onRollOver = function (){
	
	playSound("mouseOver")
}
// play music according to current scene
gameScene = "HOW TO PLAY";
playmusic();