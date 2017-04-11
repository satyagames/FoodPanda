class blockClass extends MovieClip {
	private var x:Number;
	private var y:Number;
	private var bx:Number;
	private var by:Number;
	private var speed:Number;
	private var life:Number;
	private var range:Number;
	private var xMove:Number;
	private var tx:Number;
	private var ty:Number;
	private var dx:Number;
	private var dy:Number;
	private var dist:Number;
	private var yMove:Number;
	private var angle:Number;
	private var a:Number;
	private var num:Number;
	private var cxTarget:Number;
	private var cyTarget:Number;
	private var bType:Number;
	private var top:Number;
private var left:Number;
	function onLoad():Void {
		this._x = x+_root.top
		this._y = y+_root.left
		//angle = 270;
		x = this._x;
		y = this._y;
		speed = 10;
		xMove = speed*Math.cos(angle*Math.PI/180);
		yMove = speed*Math.sin(angle*Math.PI/180);
	}
	
	function onEnterFrame():Void {
		
		//y += yMove;
		//x += xMove;
		//this._x = this.x+this.top
		//this._y = this.y+this.left
		//trace(x+top)
		// test if bullet hits anything
		
		//if (_root.hitSomething(this)){
			//removeMovieClip(this)
			//trace("bang")
			
		//}
		//trace(bType)
		//if (bType==4){
			//y-=10
			//
			// use sine wave movement
			//angle+=15+(Math.random()*20)-10
			//
				//xMove = speed*Math.cos(angle*Math.PI/180);
		//yMove = speed*Math.sin(angle*Math.PI/180);
		//}
		//if (bType==5){
			//
			//angle+=(Math.random()*20)-10
		//	this._rotation = 90+angle
				//xMove = speed*Math.cos(angle*Math.PI/180);
		//yMove = speed*Math.sin(angle*Math.PI/180);
		//}
		//if (bType==7){
			//
		//	angle+=(Math.random()*20)-10
		//	this._rotation = 90+angle
		//		xMove = speed*Math.cos(angle*Math.PI/180);
		//yMove = speed*Math.sin(angle*Math.PI/180);
		//}
		//if (bType==8){
			//
			//angle+=(Math.random()*20)-10
		//	this._rotation = 90+angle
				//xMove = speed*Math.cos(angle*Math.PI/180);
		//yMove = speed*Math.sin(angle*Math.PI/180);
		//}
		//if (bType==9){
			//
			//angle+=(Math.random()*20)-10
			//this._rotation = 90+angle
				//xMove = speed*Math.cos(angle*Math.PI/180);
		//yMove = speed*Math.sin(angle*Math.PI/180);
		//}
		//this._rotation = 90+angle
		//if (y<0||y>480||x<0||x>640){
		//removeMovieClip(this)
		//}		
	}
}
