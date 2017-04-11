import fireWorksClass;
//
progressSaved._alpha=0
function launchFireWorks(cx, cy, fxtype) {
	//eval("fireWorkSnd"+random(3)+1).start();
	
	sndR =random(3)+1
	if (sndR==1){
		fireWorkSnd1.start();
	}
	if (sndR==2){
		fireWorkSnd2.start();
	}
	if (sndR==3){
		fireWorkSnd3.start();
	}
	fxAm = random(50)+50;
	rotDiv = 360/fxAm;
	fxNum = this.fireWorksClip.getNextHighestDepth();
	this.fireWorksClip.createEmptyMovieClip("fxholder"+fxNum, fxNum);
	for (i=0; i<fxAm; i++) {
		eval("fireWorksClip.fxholder"+fxNum).attachMovie("fireWorksParticle", "fx"+i, i+100*fxNum);
		eval("fireWorksClip.fxholder"+fxNum+".fx"+i)._x = cx;
		eval("fireWorksClip.fxholder"+fxNum+".fx"+i)._y = cy;
		eval("fireWorksClip.fxholder"+fxNum+".fx"+i).gotoAndStop(fxtype);
		eval("fireWorksClip.fxholder"+fxNum+".fx"+i).rot = i*rotDiv;
		eval("fireWorksClip.fxholder"+fxNum+".fx"+i).fxtype = fxtype;
	}
}
c = 10;
this.createEmptyMovieClip("fireWorksClip", this.getNextHighestDepth());


#include "actionScript/showWord_01.as"
function addPoints(temp_Score:Number){
	score+=temp_Score
scoreTextBox.text = score

}
restartLevelBtnClip.onRollOver = function() {
	restartLevelBtnClip.scaleTo(200, 1);
};
restartLevelBtnClip.onRollOut = function() {
	restartLevelBtnClip.scaleTo(100, .5);
};
restartLevelBtnClip.onRelease = function() {
	gameState = "quit level";
};
//
menuBtnClip.onRollOver = function() {
	menuBtnClip.scaleTo(200, 1);
};
menuBtnClip.onRollOut = function() {
	menuBtnClip.scaleTo(100, .5);
};
menuBtnClip.onRelease = function() {
	gameState = "quit game";
};
//colourSchemes = new Array("ffb1b2", "009900", "990000", "333333");
//colourSchemes = new Array(1, 2, 3, 4);
for (i=0; i<6; i++) {
	t = miscHolder.attachMovie("colourSchemeClip", "colourSchemeClip"+i, i+10000);
	t.onRollOver = function (){
		
	this.ySlideTo(460,.5)
	}
	t.onRollOut = function (){
		
	this.ySlideTo(470,.5)
	}
	//colourClip = "0x"+colourSchemes[i];
	colourClip = colourSchemes[i];
	//t.colorTo(colourClip);
	t._y = 470;
	t._x = 13+i*24;
	t.colourString = i;
	if (i == 0) {
		t.colorTransformTo(200, undefined, -255, undefined, -255, undefined, undefined, undefined, 0.6, "linear");
	}
	if (i == 1) {
		t.colorTransformTo(-255, undefined, 255, undefined, -255, undefined, undefined, undefined, 0.6, "linear");
	}
	if (i == 2) {
		t.colorTransformTo(-255, undefined, -255, undefined, 200, undefined, undefined, undefined, 0.6, "linear");
	}
	if (tempColour == 3) {
		gridHolder.colorTransformTo(255, undefined, 255, undefined, -255, undefined, undefined, undefined, 0.6, "linear");
	}
	if (i == 4) {
		t.colorTransformTo(255, undefined, 128, undefined, 255, undefined, undefined, undefined, 0.6, "linear");
	}
	if (i == 5) {
		t.colorTransformTo(128, undefined, 128, undefined, -255, undefined, undefined, undefined, 0.6, "linear");
	}
	//t.colourString = colourClip;    
	
	t.onRelease = function() {
		changeThemeColour(this.colourString);
	};
}

function changeThemeColour(tempColour) {
	//gridHolder.colorTo(tempColour, 1);
	if (tempColour == 0) {
		gridHolder.colorTransformTo(200, undefined, 0, undefined, 0, undefined, undefined, undefined, 0.6, "linear");
	}
	if (tempColour == 1) {
		gridHolder.colorTransformTo(0, undefined, 200, undefined, undefined, undefined, undefined, undefined, 0.6, "linear");
	}
	if (tempColour == 2) {
		gridHolder.colorTransformTo(0, undefined, 0, undefined, 200, undefined, undefined, undefined, 0.6, "linear");
	}
	if (tempColour == 3) {
		gridHolder.colorTransformTo(255, undefined, 112, undefined, -255, undefined, undefined, undefined, 0.6, "linear");
	}
if (tempColour == 4) {
		gridHolder.colorTransformTo(255, undefined, 128, undefined, 255, undefined, undefined, undefined, 0.6, "linear");
	}
	if (tempColour == 5) {
		gridHolder.colorTransformTo(128, undefined, 128, undefined, -255, undefined, undefined, undefined, 0.6, "linear");
	}
	}

function testIndiviualBlock(tx, ty) {
	objectsCurrentX = findTheXLocation(tx+5);
	objectsCurrentY = findTheYLocation(ty+5);
	objectsCurrent2X = findTheXLocation(tx+40);
	objectsCurrent2Y = findTheYLocation(ty+40);
	if (Math.abs(xMove)>0) {
		if (xMove<0) {
			if (xMove<-20) {
				xMove = -20;
			}
			testXDir = xMove;
			testX = findTheXLocation(tx+testXDir);
			objectInTestLocation = levelData[objectsCurrentY][testX][0];
			objectInTest2Location = levelData[objectsCurrent2Y][testX][0];
		}
		if (xMove>0) {
			if (xMove>20) {
				xMove = 20;
			}
			testXDir = xMove;
			testX = findTheXLocation(tx+50);
			objectInTestLocation = levelData[objectsCurrentY][testX][0];
			objectInTest2Location = levelData[objectsCurrent2Y][testX][0];
		}
		if (objectInTestLocation == 0 && objectInTest2Location == 0) {
			//testClip._x += testXDir;testClip._x += testXDir;
			moveTheX = true;
		} else {
			dontMoveX = true;
			moveTheX = false;
		}
	}
	//                                                                        
	if (Math.abs(yMove)>0) {
		if (yMove<0) {
			if (yMove<-20) {
				yMove = -20;
			}
			testYDir = yMove;
			testY = findTheYLocation(ty+testYDir);
			objectInTestLocation = levelData[testY][objectsCurrentX][0];
			objectInTest2Location = levelData[testY][objectsCurrent2X][0];
		}
		if (yMove>0) {
			if (yMove>20) {
				yMove = 20;
			}
			testYDir = yMove;
			testY = findTheYLocation(ty+50);
			objectInTestLocation = levelData[testY][objectsCurrentX][0];
			objectInTest2Location = levelData[testY][objectsCurrent2X][0];
		}
		if (objectInTestLocation == 0 && objectInTest2Location == 0) {
			//testClip._y += testYDir;
			moveTheY = true;
		} else {
			dontMoveY = true;
			moveTheY = false;
		}
	}
}
function testBlocksMove() {
	moveTheX = false;
	moveTheY = false;
	xMove = _xmouse-testClip._x+theObjectsX;
	yMove = _ymouse-testClip._y+theObjectsY;
	typeOfBlock = testClip.typeOfBlock;
	
		dontMoveX = false;
		dontMoveY = false;
		theTempArray = eval("block"+typeOfBlock+"Type")
		for (m=0; m<theTempArray.length; m += 2) {
			testIndiviualBlock(testClip._x+(theTempArray[(m)]*50), testClip._y+(theTempArray[m+1]*50));
			if (!moveTheX) {
				dontMoveX = true;
			}
			if (!moveTheY) {
				dontMoveY = true;
			}
		}
		if (!dontMoveX) {
			if (moveTheX) {
				testClip._x += testXDir;
			}
		}
		if (!dontMoveY) {
			if (moveTheY) {
				testClip._y += testYDir;
			}
		}
	
	
}
function findBlockUserIsClicking() {
	for (i=0; i<blockNameArray.length; i++) {
		testClip = blockNameArray[i];
		if (testClip.hitTest(_xmouse, _ymouse, true)) {
			gameState = "user is dragging";
			draggingBlock = testClip;
			theObjectsX = testClip._x-_xmouse;
			theObjectsY = testClip._y-_ymouse;
			
			testX = findTheXLocation(testClip._x);
			testY = findTheYLocation(testClip._y);
		
			theBlockType = testClip.typeOfBlock;
			// release the block from the grid
			// do it based on the type of block it is
			theTempArray = eval("block"+theBlockType+"Type")
			trace("you have picked up block type "+theBlockType)
		
				//trace(theTempArray.length)
			for (l=0; l<theTempArray.length; l += 2) {
				levelData[testY+theTempArray[l+1]][testX+theTempArray[(l)]][0] = 0;
				levelData[testY+theTempArray[l]][testX+theTempArray[(l+1)]][1] = undefined;
				
			}
			lastX = testClip._x;
			lastY = testClip._y;
			gameState = "user is dragging";
			return;
		}
		
	}
		gameState = "wait for users click";
	return;	
}
onMouseDown = function () {
	trace(gameState);
	if (gameState == "wait for users click") {
		trace("mouse pressed");
		
		// find if player has clicked on a block, if so then start the dragging mode of that block
		// go through all bricks and find which one player has clicked on
		findBlockUserIsClicking();
	}
};
onMouseUp = function () {
	if (gameState == "user is dragging") {
	
		// make block snap to the nearest 50 x 50
		testX = findTheXLocation(testClip._x+25);
		testY = findTheYLocation(testClip._y+25);
		// set the block in the grid
		// release the block from the grid
		// dop it based on the type of block it is
		theTempArray = eval("block"+typeOfBlock+"Type")
			
		
		
			for (l=0; l<theTempArray.length; l += 2) {
				levelData[testY+theTempArray[l+1]][testX+theTempArray[(l)]][0] = 1;
				levelData[testY+theTempArray[l]][testX+theTempArray[(l+1)]][1] = t;
			}
		
		testClip._x = testX*50+gridXOffset;
		testClip._y = testY*50+gridYOffset;
		
		moves++;
		movesTextBox.text = moves;
		if (testClip.typeOfBlock == 4) {
			trace("solvedX = "+solvedX)
			trace("testX = "+testX )
			if (testX == solvedX && testY == solvedY) {
				trace("level solved");
				
				gameState = "level solved";
			
			}else{
			gameState = "wait for users click";
		}
		}else{
			gameState = "wait for users click";
		}
	}
};
function findTheXLocation(tempN) {
	//return (Math.floor((tempN-40)/50));
	return (Math.floor((tempN-gridXOffset )/50));
}
function findTheYLocation(tempN) {
	//return (Math.floor((tempN-40)/50));
	return (Math.floor((tempN-gridYOffset )/50));
}
function setup(){
	score=0
	//_global.level =13
	
}
function setupLevel() {
	//level=16
	levelTextBox.text = level
	blockList = new Array();
	switch(level){
		case 1:
		gridWidth = 4;
	gridHeight = 4;
		//blockList = new Array();
	blockList.push(1, 0, 0);
	blockList.push(1, 3, 0);
	blockList.push(1, 0, 3);
	blockList.push(1, 3, 3);
	blockList.push(1, 2, 1);
	blockList.push(1, 2, 2);
	blockList.push(3, 1, 0);
	blockList.push(3, 1, 3);
	blockList.push(4, 0, 1);
	solvedX = 2;
	solvedY = 1;
		break
		case 2:
				gridWidth = 6
	gridHeight = 5
		solvedX = 4;
	solvedY = 2;
	
	blockList.push(4, 0, 0)
	blockList.push(17, 1, 2)
	blockList.push(2, 3, 1)
	blockList.push(3, 4, 1)
	blockList.push(1,2, 4)
	blockList.push(1,4, 4)
	blockList.push(2,5, 2)
	blockList.push(11,3, 3)
		break
		case 3:
		gridWidth = 5;
	gridHeight = 4;
		//blockList = new Array();
	blockList.push(1, 0, 0);
	blockList.push(3, 1, 0);
	blockList.push(3, 3, 0);
	blockList.push(4, 0, 1);
	blockList.push(1, 2, 1);
	blockList.push(1, 2, 2);
	blockList.push(2, 3, 1);
	blockList.push(1, 0, 3);
	blockList.push(3, 1, 3);
	blockList.push(3, 3, 3);
	
	solvedX = 3;
	solvedY = 1;
		break
		case 4:
		gridWidth = 4;
	gridHeight = 4;
		
	blockList.push(4, 0, 0);
	blockList.push(1, 2, 0);
	blockList.push(1, 3, 0);
	blockList.push(1, 0, 2);
	blockList.push(1, 3, 1);
	blockList.push(3, 2, 3);
	blockList.push(6, 1, 1);
	solvedX = 2;
	solvedY = 1;
		break
		
		case 5:
		// level 5
		gridWidth = 5;
	gridHeight = 4;
		solvedX = 3;
	solvedY = 1;
	
	blockList.push(3, 0, 0);
	blockList.push(2, 2, 0);
	blockList.push(4, 0, 1);
blockList.push(3, 1, 3);
blockList.push(1, 3, 3);
blockList.push(7, 2, 2);
	
		break
		
		
		case 6:
		// level 6
		gridWidth = 6
	gridHeight = 4;
		solvedX = 4;
	solvedY = 1;
	
	blockList.push(1, 0, 0)
	blockList.push(1, 0, 3)
	
	blockList.push(4, 0, 1);
	blockList.push(8, 2, 0)
	blockList.push(8, 2, 2)
	blockList.push(2, 5, 1)
	
	
	
		break
		
		case 7:
		// level 7 
		gridWidth = 6
	gridHeight = 4;
		solvedX = 4;
	solvedY = 1;
	
	blockList.push(4, 0, 1)
	blockList.push(9, 2, 0)
	blockList.push(10, 2, 2)
	
	blockList.push(1, 4, 0)
	blockList.push(1, 5, 0)
	
	blockList.push(1, 4, 3)
	blockList.push(1, 5, 3)
		break
		
			case 8:
	
		gridWidth = 6
	gridHeight = 5
		solvedX = 4;
	solvedY = 2;
	
	blockList.push(4, 0, 0)
	blockList.push(6, 1, 1)
	blockList.push(6, 2, 2)
	blockList.push(6, 3, 3)
	blockList.push(5, 0, 2)
	blockList.push(5, 3, 0)
 
		break
		case 9:
	
		gridWidth = 6
	gridHeight = 5
		solvedX = 4;
	solvedY = 2;
	
	blockList.push(4, 0, 1)
	blockList.push(1, 1, 0)
	blockList.push(11, 2, 0)
	blockList.push(12, 4, 0)
	blockList.push(5, 2, 3)
	blockList.push(6, 4, 3)
	blockList.push(1, 1, 3)
	blockList.push(3, 2, 2)
	blockList.push(3, 4, 2)
	
 
		break
			case 10:
	
		gridWidth = 5
	gridHeight = 4
		solvedX = 3;
	solvedY = 1;
	
	blockList.push(4, 0, 0)
	blockList.push(3, 2, 1)
	blockList.push(12, 3, 0)
	blockList.push(5, 1, 2)
	blockList.push(1, 2, 2)
	blockList.push(2, 3, 2)
	
	
 
		break
		case 11:
	
		gridWidth = 6
	gridHeight = 5
		solvedX = 4;
	solvedY = 2;
	
	blockList.push(4, 0, 0)
	blockList.push(10, 3, 0)
	blockList.push(6, 1, 1)
	blockList.push(5, 3, 1)
	blockList.push(9, 0, 3)
	blockList.push(12, 2, 3)
	break
		case 12:
	
		gridWidth = 6
	gridHeight = 5
		solvedX = 4;
	solvedY = 2;
	
	blockList.push(4, 0, 1)
	blockList.push(1, 0, 0)
	blockList.push(1, 0, 3)
	blockList.push(3, 1, 0)
	blockList.push(3, 1, 3)
	blockList.push(8, 3, 0)
	blockList.push(1, 5, 2)
	blockList.push(13, 3, 3)
	blockList.push(14, 3, 1)
	
	break
		
	case 13:
	
		gridWidth = 6
	gridHeight = 5
		solvedX = 4;
	solvedY = 2;
	
	blockList.push(4, 1, 1)
	blockList.push(3, 1, 0)
	blockList.push(2, 0, 1)
	blockList.push(15, 3, 0)
	blockList.push(15, 2, 2)
	blockList.push(3, 1, 4)
	
	
	break
	case 14:
	
		gridWidth = 6
	gridHeight = 5
		solvedX = 4;
	solvedY = 2;
	
	blockList.push(4, 0, 1)
	blockList.push(3, 1, 0)
	blockList.push(12, 4, 0)
	blockList.push(10, 2, 1)
	blockList.push(1, 1, 3)
	blockList.push(5, 2, 3)
	blockList.push(3, 4, 4)
	blockList.push(9, 3, 2)
	
	
	break
	case 15:
	
		gridWidth = 6
	gridHeight = 5
		solvedX = 4;
	solvedY = 2;
	
	blockList.push(4, 0, 0)
	blockList.push(3, 0, 3)
	blockList.push(3, 0, 4)
	blockList.push(15, 2, 1)
	blockList.push(2, 4, 0)
	blockList.push(14, 5, 0)
	blockList.push(2, 4, 3)
	blockList.push(2, 5, 3)
	
	
	break
	case 16:
	
		gridWidth = 6
	gridHeight = 5
		solvedX = 4;
	solvedY = 2;
	
	blockList.push(4, 0, 1)
	blockList.push(11, 2, 0)
	blockList.push(3, 4, 0)
	blockList.push(5, 2, 3)
	blockList.push(3, 4, 4)
	blockList.push(16, 2, 1)
	blockList.push(16, 4, 1)
	
	
	
	break
		case 17:
	
		gridWidth = 6
	gridHeight = 5
		solvedX = 4;
	solvedY = 2;
	
	blockList.push(4, 0, 1)
	blockList.push(8, 1, 0)
	blockList.push(1, 3, 0)
	blockList.push(3, 4, 0)
	blockList.push(17, 3, 1)
	blockList.push(16, 1, 2)
	blockList.push(1, 1, 4)
	
	
	
	break
		case 18:
	
		gridWidth = 6
	gridHeight = 5
		solvedX = 4;
	solvedY = 2;
	
	blockList.push(4, 0, 0)
	blockList.push(3, 2, 0)
	blockList.push(17, 4, 0)
	blockList.push(17, 1, 2)
	blockList.push(14,3, 1)
	blockList.push(1,4, 3)
	blockList.push(3, 3, 4)
	
	
	
	break
	
	case 19:
		gridWidth = 6
	gridHeight = 5
		solvedX = 4;
	solvedY = 2;
	
	blockList.push(4, 0, 1)
	blockList.push(1, 0, 0)
	blockList.push(3, 0, 3)
	blockList.push(11, 2, 0)
	blockList.push(2,5, 0)
	blockList.push(15,3, 1)
	blockList.push(5,2, 3)
	blockList.push(2,5, 3)
	
	
	
	break
		
	case 20:

	
		gridWidth = 4;
	gridHeight = 4;
		//blockList = new Array();
	blockList.push(4, 0, 0);
	blockList.push(2, 2, 0);
	blockList.push(1, 3, 0);
	blockList.push(1, 0, 2);
	blockList.push(1, 1, 2);
	blockList.push(1, 2, 2);
	blockList.push(3,0, 3);
	blockList.push(1, 2, 3);
	blockList.push(1, 3, 3);
	solvedX = 2;
	solvedY = 1;
	
	
	break
	}
		
	gridXOffset = (640-(gridWidth *50))/2;
	// compensate the grid x position for the exit panel width divided by two
	

	gridYOffset = (480-(gridHeight *50))/2
// move the grid up a bit for visual balance
		gridXOffset-=50

	// show exit location
	t = gridHolder.attachMovie("solvedPosition","solvedPosition",1000)
	t._x = solvedX*50+gridXOffset
	t._y = solvedY*50+gridYOffset
	
	
	moves = 0;
	movesTextBox.text = moves
	//trace(gameState)
	// set up grid
	
	
	//trace("setup level");
	arrayNum = 0;
	levelData = new Array();
	
	for (i=0; i<100; i++) {
		removeMovieClip(eval("gridHolder.g"+i))
		 removeMovieClip(eval("blockHolder.block"+i))
	}
	
	for (i=0; i<gridHeight; i++) {
		levelData[i] = new Array();
		for (j=0; j<gridWidth; j++) {
			t = gridHolder.attachMovie("grid", "g"+arrayNum, arrayNum+1500);
			
			t._x = j*50+gridXOffset;
			t._y = i*50+gridYOffset;
			theData = newLevelData[arrayNum];
			levelData[i][j] = new Array();
			levelData[i][j][0] = 0;
			arrayNum++;
		}
	}
	// attach blocks
	// clock list vars go like this - type,x,y - NOTES: x and y are based on the grid, they get times by 50 when putting the blocks down
	//blockList = new Array(1, 1, 0, 2, 4, 2);
	//blockList.push(3, 2, 4);
	
	// blocks
	// 1 block
	block1Type = new Array(0, 0);
	// 2 blocks, one on top of the other
	block2Type = new Array(0, 0, 0, 1);
	// 2 blocks, side by side
	block3Type = new Array(0, 0, 1, 0);
	// KING BLOCK
	block4Type = new Array(0, 0, 1, 0, 0, 1, 1, 1);
	// L shape to the right
	block5Type = new Array(0, 0, 0, 1, 1, 1);
	// L shape to the left
	block6Type = new Array(1, 0, 0, 1, 1, 1);
	// 3 in a row to the left
	block7Type = new Array(0, 0, 1, 0, 2, 0);
	// 2 across, then 2 across in a z
	block8Type = new Array(0, 0, 1, 0, 1, 1,2,1);
	
	// 2 across, then 2 across in a z
	block9Type = new Array(0, 1, 1, 0, 2, 1,1,1);
	// 2 across, then 2 across in a z
	block10Type = new Array(0, 0, 1,0,2,0,1,1);
	
		block11Type = new Array(0, 0, 1,0,0,1);
		block12Type = new Array(0, 0, 1,0,1,1);
		block13Type = new Array(1, 0, 2,0,0,1,1,1);
		block14Type = new Array(0, 0, 0,1,0,2);
		block15Type = new Array(1, 0, 0,1,1,1,2,1,1,2);
		block16Type = new Array(1, 0, 0,1,1,1,1,2);
		block17Type = new Array(1, 0, 0,1,1,1,0,2);
	//
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
		t._x = blockx*50+gridXOffset
		//trace(t.x);
		t.y = blocky*50;
		t._y = blocky*50+gridYOffset;
		trace(t._y)
		blockNumber++;
		blockNameArray.push(t);
		// set all the parts into level data that are part of that block
		theTempArray = eval("block"+typeOfBlock+"Type")
		//trace("theTempArray = "+theTempArray)
		
		//if (typeOfBlock == 1) {
			//levelData[blocky][blockx][0] = 1;
			//levelData[blocky][blockx][1] = t;
		//}
		//if (typeOfBlock == 2) {
		trace("block number "+k/3+" is type "+typeOfBlock)
			for (l=0; l<theTempArray.length; l += 2) {
				levelData[blocky+theTempArray[l+1]][blockx+theTempArray[(l)]][0] = 1;
				levelData[blocky+theTempArray[l]][blockx+theTempArray[(l+1)]][1] = t;
			}
		//}
		
		
	}
	trace("blockNameArray = "+blockNameArray)
	gameState = "wait for users click";
}

gameLoop = function () {
	gameStateTextBox.text = gameState;
	//trace(gameState) 
	switch (gameState) {
		case "wait for users click" :
		break;
	case "quit game":
	gameState = "null"
	gotoAndPlay("INTRO",1)
	break
		case "quit level":
	showWord("restart","slide zoom 3",335,240)
	blockHolder.alphaTo(0,1,"easeInSine")
	gameState = "quit level wait"
qlw = 60
	break
	case "quit level wait":
	qlw--
	if (qlw<1){
		blockHolder.alphaTo(100,.5,"easeOutSine",.5)
		
			gameState = "setup level"
			
	}

	break
	
	case "user is dragging" :
		// find the directiojns the user is draggin in
		// test if this block can move into the position in the direction of the users mouse
		testBlocksMove();
		break;
	case "level solved" :
	// level is complete, save it to players local flash storage
	
	if (levelsUnlocked<=(level+1)){
		trace("level up")
		
			levelsUnlocked = level+1
			storage.data.levelsUnlocked =levelsUnlocked 
			storage.flush()
			
		}
		
		trace("trace(storage.data.levelsUnlocked) = "+storage.data.levelsUnlocked)
		
	//blockHolder.alphaTo(0,.5,"easeInSine")
	// slide king block out
	testClip.slideTo(solvedX*50+gridXOffset+100,solvedY*50+gridYOffset,1,"",.5)
	
		
		//levelPoints = 1000-(moves*10)
		levelPoints = moves
		
		if (levelPoints <0){
				//showWord("no Bonus","slide down bounce",320,150);
	}else{
				//showWord((levelPoints+" bonus points"),"slide down bounce",320,150,1,undefined,true,10);	
		addPoints(	levelPoints)
		}
		trace(levelPoints )
		
			//showWord("Level Complete","slide down bounce",undefined,undefined,1);
			//showWord(levelPoints+" level points","easeInExpo",320,190)
			
		// add up points, for how long player took , how many moves etc
		trace(gameState);
		lcw=90
		
		
		
		gameState = "level complete wait";
		break;
		case "level complete wait":
		progressSaved.alphaTo(100,1,"",4,function (){
			this.alphaTo(0,2,"",4)
			
		})
		lcw--
		if (Math.random()*10<.9){
			
		launchFireWorks(Math.random()*400+70, Math.random()*200+60, Math.floor(Math.random()*3)+1)
		}
	
		if (lcw<1){
			
			level++
			if (level>20){
				gameState = "game complete"
			}else{
				
				gameState = "setup level"
			}
		}
		break
		case "setup":
		setup()
		gameState = "setup level"
		break
		case "setup level":
		
	
		setupLevel();
		blockHolder.alphaTo(100,.5,"easeOutSine",.5)
		slw=60
		//showWord("Level "+level,"slide random smooth",undefined,undefined,2)
		showWord("level "+level,"slide down bounce",320,100,1)
		gameState = "setup level wait"
		break
		case "setup level wait":
		slw--
		if (slw<1){
		gameState =	"wait for users click"
			
		}
		break
		case "game complete":
		showWord("g r e a t!","slide down bounce",320,100)
		gcw=60
		gameState = "game complete wait"
		break
		case "game complete wait":
		gcw--
		if (gcw<1){
			
			gameState = "wait"
			gotoAndPlay("GAME COMPLETE",1)
		}
		break
	}
};
gameTimeDelay = 32;
theGameLoop = setInterval(this, "gameLoop", gameTimeDelay);
