class letter_1_Class extends MovieClip {
	private var d:Number;
	
	private var a:Number;
	
	function onLoad():Void {
		this._alpha =0
		this._xscale = this._yscale =200
		//this._rotation=(350)
	d=random(30)
	}
	
	function onEnterFrame():Void {
	if (d>0){
		d--
	}else{
		
		if (this._alpha==0){
			this._alpha=6
		}
		if (this._alpha<100){
			this._alpha*=1.1
			//trace(this._alpha)
		}
		if (this._xscale >100){
			a = (this._xscale-100)/10
		//	trace(a)
			this._xscale = this._yscale -=a
		}
	
	}
}}
