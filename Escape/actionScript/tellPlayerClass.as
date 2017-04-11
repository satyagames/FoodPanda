class tellPlayerClass extends MovieClip {
	private var x:Number;
	private var y:Number;
	private var l:Number;
	function onLoad():Void {
		this._x = 320;
		this._y = 100;
		l = 230;
		this._xscale = this._yscale=50;
		this._alpha = 50;
	}
	function onEnterFrame():Void {
		if (this._xscale>130) {
			this._alpha -= 2;
		} else if (this._alpha<100) {
			this._alpha += 5;
		}
		this._xscale = this._yscale += 2;
		l--;
		if (l<1) {
			removeMovieClip(this);
		}
	}
}
