// game over scripts
if (score>yourhigh) {
	yourhigh = score;
	storage.data.myhighscore = score;
}
// play music according to current scene
gameScene = "GAME FINISHED";
playmusic();
this.okBtn.onRelease = function () {
	gotoAndPlay("INTRO", 1);
}
this.okBtn.onRollOver = function (){
	playSound("mouseOver")
}