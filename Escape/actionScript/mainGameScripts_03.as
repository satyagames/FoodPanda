import flash.geom.Rectangle;
/////////// tell player
function tellplayer(temp) {
	trace("tell player");
	//showWord(temp,"slide random smooth" ,320,240,1.5,this,true)
	showWord(temp, "scale down", 320, 240, 2, _level0, true);
}
/////////// pause code
pauseBtn.onPress = function() {
	pausebtnpress();
};
function pausebtnpress() {
	if (_root.state == "playing") {
		_root.state = "paused";
		attachMovie("paused_clip", "tellPlayer", 9);
		tellPlayer._x = 320;
		tellPlayer._y = 240;
	} else if (_root.state == "paused") {
		removeMovieClip("tellPlayer");
		_root.state = "playing";
	}
}
onMouseDown = function () {
	trace(gameState);
	if (gameState == "waiting for users click") {
		trace("mouse pressed");
		gameState = "user is dragging";
		// find if player has clicked on a block, if so then start the dragging mode of that block
		// go through all bricks and find which one player has clicked on
		for (i=0; i<blockNameArray.length; i++) {
			testClip = blockNameArray[i];
			if (testClip.hitTest(_xmouse, _ymouse, true)) {
				trace(blockNameArray[i]);
				gameState = "user is dragging";
				draggingBlock = testClip;
				xMouseOffset = testClip._x-_xmouse;
				lastX = testClip._x;
				lastY = testClip._y;
				yMouseOffset = testClip._y-_ymouse;
				i = 1000;
			}
		}
	}
};
function snapBlocktoGrid() {
	// MAKE BLOCK SNAP TO THE 50 X 50 GRID
	snapGridSize = 20;
	snapGridSizeHalf = 10;
	snapX = Math.floor((testClip._x-gridXOffset+snapGridSizeHalf)/snapGridSize)*snapGridSize+gridXOffset;
	snapY = Math.floor((testClip._y-gridYOffset+snapGridSizeHalf)/snapGridSize)*snapGridSize+gridYOffset;
	trace("snapX = "+snapX);
	testClip._x = snapX;
	testClip._y = snapY;
}
onMouseUp = function () {
	if (gameState=="user is dragging"){
	trace("mouse released");
	snapBlocktoGrid();
	gameState = "waiting for users click";
	}
};
function getTheNumberBack(tempNumber){
	return(	Math.floor((tempNumber-40)/20)*20+40)
}
onMouseMove = function () {
	lastXTextBox.text = lastX;
	if (gameState == "user is dragging") {
		//mx=_xmouse-testClip._x/10
		//my=_ymouse-testClip._y/10
		currentXPosition = _xmouse+xMouseOffset;
		//tempClip._x+
		//tempClip._y+
		currentYPosition = _ymouse+yMouseOffset;
		
		//trace(moveX)
		// if players mouse leave the block, then drop the block
		// test if block can move into new position
		// go through list of objects, if there is a collision, revert back to lastX and lastY
		xfail = false;
		yfail = false;
		for (i=0; i<blockNameArray.length+1; i++) {
			hitTestClip = blockNameArray[i];
			if (testClip != hitTestClip) {
				if (testClip.hitTest(hitTestClip)) {
					var collisionRect:Rectangle = CollisionDetection.checkForCollision(hitTestClip, testClip, 250);
					if (collisionRect) {
						trace("collisionRect = "+collisionRect)
						//trace("collisionRect.width = "+collisionRect.width);
				
						//snapBlocktoGrid();
						i = 1000;
						
					}
				} 
				
			}
		}
		// tested all blocks
		//if there is no collision then move block
		moveX = (lastX-currentXPosition);
		moveY = (lastY-currentYPosition);
		if (collisionRect) {
			//if (moveX>30 ) {
							//if (collisionRect.x<=testClip._x) {
								//testClip._x = lastX;
								//testClip._x += lastX-currentXPosition;
								//testClip._x +=collisionRect.width
								testClip._x +=moveX 
								//trace("hit on left side")
								//trace(lastX);
								//xfail = true;
								//
							//} else if (collisionRect.width+testClip._x>=testClip._x) {
								//testClip._x = lastX;
								//testClip._x -=collisionRect.width
								//testClip._x -=moveX 
								//trace("hit on right side")
								//
								//xfail = true;
							//}
						//}
						//if (moveY>30) {
							//if (collisionRect.y<=testClip._y) {
								//trace("hit on top")
								//testClip._y = lastY;
								testClip._y-=moveY
								gameState = "waiting for users click";
								//yfail = true;
							//} else if (collisionRect.width+testClip._y>=testClip._y) {
								//testClip._y = lastY;
								//trace("hit on bottom")
								//yfail = true;
							//}
						//}
			//if (xfail && yfail) {
							//snapBlocktoGrid();
							//gameState = "waiting for users click";
						//}
		}
		if (!xfail){
			
				lastX =	getTheNumberBack(currentXPosition)
					testClip._x = lastX
		}
		if (!yfail){
			
			lastY = getTheNumberBack(currentYPosition)
					testClip._y = 	lastY
		}
		//gameState = "waiting for users click";
		//if (!collisionRect) {
					// drag is good, update blocks position
					//trace("drag is good");
					//lastX = currentXPosition;
				
					//lastY = getTheNumberBack(currentYPosition)
					//testClip._y = 	lastY
		//}
	}
};
//
gameLoop = function () {
	gameStateTextBox.text = gameState;
	fpsCounter++;
	//trace(gameState) 
	switch (gameState) {
	case "playing" :
		break;
	case "waiting for users click" :
		break;
	case "user is dragging" :
		break;
	case "setup" :
		setup();
		trace(gameState);
		gameState = "setup level";
		break;
	case "level announce" :
		if (level != 4 || level != 8) {
			trace("Level "+level);
			//tellPlayer("Level "+level);
			showWord("Level "+level, "scale down", 320, 240, 2, _level0, true);
		} else {
			tellPlayer("BONUS LEVEL "+level);
		}
		lac = 30;
		gameState = "level announce wait";
		break;
	case "level announce wait" :
		lac--;
		if (lac<1) {
			gameState = "waiting for users click";
		}
		break;
	case "game over" :
		playSound("game over");
		tellPlayer("Game Over");
		gow = 60;
		gameState = "game over wait";
		break;
	case "game over wait" :
		gow--;
		if (gow<1) {
			trace("game over");
			gotoAndPlay("GAME OVER", 1);
			delete (theGameLoop);
			gameState = "null";
		}
		break;
	case "lose life" :
		gameState = "lose life wait";
		break;
	case "lose life wait" :
		gameState = "setup level";
		break;
	case "setup level" :
		trace(gameState);
		setupLevel();
		gameState = "level announce";
		break;
	case "level complete" :
		blockHolder._visible = false;
		playSound("level complete");
		tellPlayer("Level complete");
		timeText.text = 0;
		new Tween(timeClip, "_y", Strong.easeOut, timeClip._y, 151, 3, true);
		addTimePoints(bonus);
		// make all balls fall off screen
		gameState = "level complete wait 1";
		break;
	case "level complete wait 1" :
		lcw--;
		if (lcw<1) {
			lcw = 35;
			gameState = "level complete wait 2";
			//gameState = "next level";
		}
		break;
	case "level complete wait 2" :
		lcw--;
		if (lcw<1) {
			gameState = "next level";
		}
		break;
	case "next level" :
		level++;
		if (level>10) {
			gameState = "game complete";
		} else {
			setupLevel();
			gameState = "level announce";
		}
		break;
	case "game complete" :
		playSound("game over");
		tellPlayer("Game Complete");
		gow = 60;
		gameState = "game complete wait";
		break;
		break;
	case "game complete wait" :
		gow--;
		if (gow<1) {
			trace("game over");
			gotoAndPlay("GAME COMPLETE", 1);
			delete (theGameLoop);
			gameState = "null";
		}
		break;
	default :
		break;
	}
};
psCounter = 0;
var intervalId:Number;
var duration:Number = 1000;
function fpsReport():Void {
	fps = fpsCounter;
	fpsCounter = 0;
}
intervalId = setInterval(this, "fpsReport", duration);
function setup() {
	level = 1;
	_quality = _root.gameQuality;
	// MOUSE CLICK LISTENER
	var mlisten:Object = new Object();
	mlisten.onMouseDown = function() {
		if (playerState == 1 && state == "playing") {
			trace("mouse clicked");
		}
	};
	Mouse.addListener(mlisten);
	// SET UP VARIABLES
	extralives = 0;
	lives = 2;
	score = 0;
	// gameState = current game state
	gameState = "begin";
	// play music according to current scene
	gameScene = "GAME";
	playmusic();
}
if (musicstate == 0) {
	// DISPLAY MUSIC ON/OFF BUTTON CORRECTLY
	this.on_off.gotoAndStop(2);
}
function keyTester() {
	// make the player face the right direction (and animation)
	//  make it so player can only press in one direction at a time
	if (Key.isDown(Key.LEFT)) {
		//trace("left")
		if (px>40) {
			pxTarget -= 12;
		}
	}
	if (Key.isDown(Key.RIGHT)) {
		if (px<600) {
			pxTarget += 12;
		}
	}
	if (Key.isDown(Key.UP)) {
		//trace("left")
		if (py>40) {
			pyTarget -= 10;
		}
	}
	if (Key.isDown(Key.DOWN)) {
		if (py<600) {
			pyTarget += 10;
		}
	}
	if (fireDelay>0) {
		fireDelay--;
	}
	if (fireDelay == 0 && gameState == "playing") {
		if (Key.isDown(Key.SPACE)) {
			//trace("678686")
			fireDelay = 10;
			playerFires();
		}
	}
}
/////////// set up level
function setupLevel() {
	//trace(gameState)
	// set up grid
	gridXOffset = 40;
	gridYOffset = 40;
	gridWidth = 10;
	gridHeight = 8;
	trace("setup level");
	arrayNum = 0;
	levelData = new Array();
	for (i=0; i<gridHeight; i++) {
		levelData[i] = new Array();
		for (j=0; j<gridWidth; j++) {
			t = gridHolder.attachMovie("grid", "g"+arrayNum, arrayNum);
			t._x = j*50+gridXOffset;
			t._y = i*50+gridYOffset;
			theData = newLevelData[arrayNum];
			levelData[i][j] = new Array();
			levelData[i][j][0] = theData;
			arrayNum++;
		}
	}
	// attach blocks
	// clock list vars go like this - type,x,y - NOTES: x and y are based on the grid, they get times by 50 when putting the blocks down
	blockList = new Array(1, 0, 0, 2, 2, 0, 3, 4, 1);
	blockNumber = 1;
	blockNameArray = new Array();
	for (k=0; k<blockList.length; k += 3) {
		typeOfBlock = blockList[k];
		blockx = blockList[k+1];
		blocky = blockList[k+2];
		t = blockHolder.attachMovie("block", "block"+blockNumber, blockNumber);
		t.top = 40;
		t.left = 40;
		t.typeOfBlock = typeOfBlock;
		t.gotoAndStop(typeOfBlock);
		t.x = blockx*50;
		t._x = blockx*50+40;
		trace(t.x);
		t.y = blocky*50;
		t._y = blocky*50+40;
		blockNumber++;
		blockNameArray.push(t);
	}
	trace(blockNameArray);
	_root.gameState = "paused";
	_root.levelann = "Level "+level;
	trace("LEVEL START"+level);
	attachMovie("level_announce", "tellPlayer", 9);
	tellPlayer._x = 320;
	tellPlayer._y = 240;
	background.gotoAndStop(level);
	// remove clips routine
	for (i=0; i<500; i++) {
		removeMovieClip(eval("holder.clip"+i));
	}
	// player level = 199
	attachMovie("player", "player", 199);
	player._x = 320;
	player._y = 430;
	playerState = 1;
	// set up an array based on level
	temparray = eval("level"+level+"data");
	_root.enemyLevelStart = 1;
	_root.enemyLevel = _root.enemyLevelStart;
	_root.gameArray = new Array();
	// set up enemys (may need to be coded differently depending on game)
	for (i=0; i<100; i++) {
		ran = temparray[i];
		if (ran>0) {
			// find strength of brick
			enemyHolder.attachMovie(bname, "br"+enemyLevel, enemylevell+i);
			with (eval("enemyHolder.br"+enemylevel)) {
				gotoAndStop(ran);
				_x = enemyX;
				_y = enemyY;
				clip.enemyKind = ran;
				clip.state = "normal";
			}
		}
		_root.enemyLevel++;
		gameArray[i] = ran;
	}
	playmusic();
}
gameTimeDelay = 32;
theGameLoop = setInterval(this, "gameLoop", gameTimeDelay);
