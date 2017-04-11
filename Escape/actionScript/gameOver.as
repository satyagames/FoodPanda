if (score>yourhigh) {
	yourhigh = score;
	storage.data.myhighscore = score;
} 
storage.flush();
gamescene = "game over";
playmusic();
// 
this.okBtn.onRelease = function () {
	gotoAndPlay("INTRO", 1);
}
this.okBtn.onRollOver = function (){
	playSound("mouseOver")
}