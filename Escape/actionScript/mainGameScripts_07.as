#include "actionScript/showWord_01.as"
function addPoints(temp_Score:Number){
	score+=tempScore
scoreTextBox.text = score
}

//colourSchemes = new Array("ffb1b2", "009900", "990000", "333333");
//colourSchemes = new Array(1, 2, 3, 4);
for (i=0; i<6; i++) {
	t = miscHolder.attachMovie("colourSchemeClip", "colourSchemeClip"+i, i+10000);
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
	// go through all of the sub-blocks for this block and test if it can move. 
	//if (typeOfBlock == 1) {
		//testIndiviualBlock(testClip._x, testClip._y);
		//if (moveTheX) {
			//testClip._x += testXDir;
		//}
		//if (moveTheY) {
			//testClip._y += testYDir;
		//}
	//}
	//if (typeOfBlock == 2) {
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
	_global.level =1
	
}
function setupLevel() {
	
	levelTextBox.text = level
	switch(level){
		case 1:
		gridWidth = 4;
	gridHeight = 4;
		blockList = new Array();
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
		gridWidth = 4;
	gridHeight = 4;
		blockList = new Array();
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
		case 3:
		gridWidth = 5;
	gridHeight = 4;
		blockList = new Array();
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
		blockList = new Array();
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
	}
		//gridWidth = 4;
	//gridHeight = 4;
	gridXOffset = (640-(gridWidth *50))/2;
	// compensate the grid x position for the exit panel width divided by two
		//gridXOffset-=50
		//gridXOffset-=25

	gridYOffset = (480-(gridHeight *50))/2
// move the grid up a bit for visual balance
		gridXOffset-=50

	// show exit location
	t = gridHolder.attachMovie("solvedPosition","solvedPosition",1000)
	t._x = solvedX*50+gridXOffset
	t._y = solvedY*50+gridYOffset
	
	moves = 0;
	
	//trace(gameState)
	// set up grid
	
	
	//trace("setup level");
	arrayNum = 0;
	levelData = new Array();
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
		
		//
		//if (typeOfBlock == 3) {
			//for (l=0; l<block3Type.length; l += 2) {
				//levelData[blocky+block3Type[l+1]][blockx+block3Type[(l)]][0] = 1;
				//levelData[blocky+block3Type[l]][blockx+block3Type[(l+1)]][1] = t;
			//}
		//}
		//if (typeOfBlock == 4) {
			//for (l=0; l<block4Type.length; l += 2) {
				//levelData[blocky+block4Type[l+1]][blockx+block4Type[(l)]][0] = 1;
				//levelData[blocky+block4Type[l]][blockx+block4Type[(l+1)]][1] = t;
			//}
		//}
		//if (typeOfBlock == 5) {
			//for (l=0; l<block5Type.length; l += 2) {
				//levelData[blocky+block5Type[l+1]][blockx+block5Type[(l)]][0] = 1;
				//levelData[blocky+block5Type[l]][blockx+block5Type[(l+1)]][1] = t;
			//}
		//}
		//if (typeOfBlock == 6) {
			//for (l=0; l<block6Type.length; l += 2) {
				//levelData[blocky+block6Type[l+1]][blockx+block6Type[(l)]][0] = 1;
				//levelData[blocky+block6Type[l]][blockx+block6Type[(l+1)]][1] = t;
			//}
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
	case "user is dragging" :
		// find the directiojns the user is draggin in
		// test if this block can move into the position in the direction of the users mouse
		testBlocksMove();
		break;
	case "level solved" :
	// slide king block out
	testClip.slideTo(solvedX*50+gridXOffset+100,solvedY*50+gridYOffset,1,"",.5)
		showWord("Level Complete","slide random smooth",undefined,undefined,2);
		// add up points, for how long player took , how many moves etc
		trace(gameState);
		lcw=120
		gameState = "level complete wait";
		break;
		case "level complete wait":
		lcw--
		if (lcw<1){
			
			level++
			if (level>4){
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
		slw=60
		showWord("Level "+level,"slide random smooth",undefined,undefined,2)
		gameState = "setup level wait"
		break
		case "setup level wait":
		slw--
		if (slw<1){
		gameState =	"wait for users click"
			
		}
		break
		case "game complete":
		showWord("Game Completed")
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
