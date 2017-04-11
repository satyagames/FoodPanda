class lvlBtnClass extends MovieClip {
	private var angle:Number;
	private var x:Number;
	private var y:Number;
	private var centerY:Number;
	private var radiusY:Number;
	private var bState:Boolean;
	private var c:Number;
	private var num:Number;
	function onLoad() {
		//num = random(50);
		angle = 0;
		bState = false;
		c = 120;
		//this.gotoAndStop(1);
	}
	function onEnterFrame() {
		if (bState) {
			//this.gotoAndStop(2);
		} else {
			//this.gotoAndStop(1);
		}
	}
}
