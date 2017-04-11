// intro scene code
_quality = "HIGH";
if (musicstate == 0) {
	this.musicModeClip.on_off.gotoAndStop(2);
}
function musicOn() {
	this.options.on_off.gotoAndStop(1);
	musicstate = 1;
	storage.data.musicsetting = 1;
	playmusic();
}
function musicOff() {
	stopmusic();
	this.options.on_off.gotoAndStop(2);
	musicstate = 0;
	storage.data.musicsetting = 0;
}
//
this.playBtn.onRelease = function (){
	gotoAndPlay("GAME", 1);
	playSound("mouseDown")
}
this.playBtn.onRollOver = function (){
	playSound("mouseOver")
}
this.yourHighClip.reset_btn.onRelease = function (){
	
	playSound("mouseDown")
	_highscore = 0;
	yourHighClip.resetclip.gotoAndPlay(2);
	storage.data.highscore = 0
	storage.flush();
}
this.yourHighClip.reset_btn.onRollOver = function (){
	
	playSound("mouseOver")
}
this.howToPlayBtn.onRelease = function (){
	gotoAndPlay("HOW TO PLAY", 1);
	playSound("mouseDown")
}
this.howToPlayBtn.onRollOver = function (){
	playSound("mouseOver")
}
// play music according to current scene
gameScene = "INTRO";
playmusic();
