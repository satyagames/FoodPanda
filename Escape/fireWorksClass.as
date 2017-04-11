class fireWorksClass extends MovieClip {
	private var x:Number;
	private var y:Number;
	private var speed:Number;
	private var hitBat:Boolean;
	private var xCenter:Number;
	private var yCenter:Number;
	private var rot:Number;
	private var temprot:Number;
	private var depth:Number;
	private var fall:Number;
		private var fxtype:Number;
	function onLoad():Void {
		x = this._x;
		y = this._y;
		xCenter = this._x;
		yCenter = this._y;
		
		depth = 1;
		fall = Math.random(.2)+.5
		this._rotation = random(360)
		if (fxtype==1){
			speed=random(5)+4
		}
		if (fxtype==2){
			speed=random(9)+4
		}
		if (fxtype==3){
			speed=random(5)+4
		}
	}
	function onEnterFrame():Void {
		// acclerate ball to maximum speed for this level
		depth += speed;
		speed *= .95;
		if (speed<3) {
			yCenter += fall;
			fall *= 1.1;
			this._alpha -= 3;
			if (this._alpha<10) {
				removeMovieClip(this);
			}
		}
		temprot = (rot/180)*Math.PI;
		x = xCenter+depth*(Math.sin(temprot));
		y = yCenter+depth*(Math.cos(temprot));
		this._x = x;
		this._y = y;
		// remove if leaves bottom of screen
		if (x<0 || x>640 || y<00 || y>480) {
			removeMovieClip(this);
		}
	}
}
/*
function asteroidClass() {
}
asteroidClass.prototype = new MovieClip();
asteroidClass.prototype.onLoad = function() {
this.rot = random(360);
//this.depth = 2;
this.strength = 6;
this.pointsawarded = 500;
this.state = "normal";
this.clip._visible = false;
};
asteroidClass.prototype.onEnterFrame = function() {
if (_root.gameState != "paused") {
if (this.state == "explode") {
explodeSnd3.start();
_root.addExplosion(this.rot, this.clip.depth);
removeMovieClip(this);
}
if (this.state == "normal") {
this.clip.depth *= zoomSpeed
if (_root.gameState == "level finished wait") {
if (this.clip.depth<15) {
removeMovieClip(this);
}
this.clip.depth *= exitZoomSpeed
}
if (this.clip.depth>400) {
removeMovieClip(this);
}
// test if hit by players bullet                
this.shot = _root.testShot(this.clip);
if (this.shot != false) {
this.strength--;
if (this.strength<1) {
this.state = "explode";
_root.score += this.pointsawarded;
}
}
// test if hit player                
this.hitplayer = _root.testHitPlayer(this.clip);
if (this.hitplayer != false && this.hitplayer != undefined) {
if (_root.gameState != "level finished wait") {
// player has been hit by a mine!
_root.playerHit("asteroid");
this.state = "explode";
}
}
}
this._x = _root.calcX(this.rot, this.clip.depth);
this._y = _root.calcY(this.rot, this.clip.depth);
this.scale = _root.calcScale(this.clip.depth);
this._xscale = this._yscale=this.scale;
}
};
Object.registerClass("asteroid", asteroidClass);
*/
