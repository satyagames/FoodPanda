// preload code
gameLoadingName = "centipede";

loadingClip.onEnterFrame = function() {
	pL = Math.floor(this._parent.getBytesLoaded()/this._parent.getBytesTotal()*100);
	if (pL<100) {
		this.mask._xscale = (pL/100)*100;
		this._parent.stop();
	} else {
		for (i=0; i<stringLength; i++) {
			removeMovieClip(eval("loadingHolder.l"+i));
		}
		this._parent.play();
	}
};
stringLength = gameLoadingName.length;
wordOffset = (stringLength*20)/2;
this.createEmptyMovieClip("loadingHolder", 1);
loadingHolder._x = 320-wordOffset+10;
loadingHolder._y = 175;
for (i=0; i<stringLength; i++) {
	t = loadingHolder.attachMovie("letter", "l"+i, i);
	t._x = i*20;
	t.angle = i
t.Lvar.text = gameLoadingName.charAt(i);
t._xscale = t._yscale=200
}
stop();