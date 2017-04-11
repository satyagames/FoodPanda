class letterClass extends MovieClip {
	// creates a up and downwards motion
	//public var gameState:String;
	public var angle:Number;
	private var x:Number;
	private var y:Number;
	private var centerY:Number;
	private var radiusY:Number;
	private var speed:Number;
	function onLoad():Void {
		//trace(this)
		centerY = 48;
		// radius controls how far the object will move in said direction
		radiusY = 5;
		// speed determines how fast it will flucuate
		speed = .05;
		y = this._y;
		x = this._x;
	}
	function onEnterFrame():Void {
		//trace(this)
		if (angle != undefined) {
			y = centerY+(Math.sin(angle)*radiusY);
			angle += speed;
			this._x = this.x;
			this._y = this.y;
		}
	}
}
