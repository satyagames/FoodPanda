#include "actionScript/showWord_01.as"
// test 3, extend the blocks so that they contain more than 1 block , try for 2 stacked, L shape, T shape 
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
	if (typeOfBlock == 1) {
		testIndiviualBlock(testClip._x, testClip._y);
		if (moveTheX) {
			testClip._x += testXDir;
		}
		if (moveTheY) {
			testClip._y += testYDir;
		}
	}
	if (typeOfBlock == 2) {
		dontMoveX = false;
		dontMoveY = false;
		for (m=0; m<block2Type.length; m += 2) {
			testIndiviualBlock(testClip._x+(block2Type[(m)]*50), testClip._y+(block2Type[m+1]*50));
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
	if (typeOfBlock == 3) {
		dontMoveX = false;
		dontMoveY = false;
		for (m=0; m<block3Type.length; m += 2) {
			testIndiviualBlock(testClip._x+(block3Type[(m)]*50), testClip._y+(block3Type[m+1]*50));
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
	if (typeOfBlock == 4) {
		dontMoveX = false;
		dontMoveY = false;
		for (m=0; m<block4Type.length; m += 2) {
			testIndiviualBlock(testClip._x+(block4Type[(m)]*50), testClip._y+(block4Type[m+1]*50));
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
}
function findBlockUserIsClicking() {
	for (i=0; i<blockNameArray.length; i++) {
		testClip = blockNameArray[i];
		if (testClip.hitTest(_xmouse, _ymouse, true)) {
			//trace(blockNameArray[i]);
			gameState = "user is dragging";
			draggingBlock = testClip;
			theObjectsX = testClip._x-_xmouse;
			theObjectsY = testClip._y-_ymouse;
			//xMouseOffset = testClip._x-_xmouse;
			testX = findTheXLocation(testClip._x);
			testY = findTheYLocation(testClip._y);
			//trace("testClip.typeOfBlock = "+testClip.typeOfBlock);
			theBlockType = testClip.typeOfBlock;
			// release the block from the grid
			// dop it based on the type of block it is
			if (theBlockType == 1) {
				levelData[testY][testX][0] = 0;
				levelData[testY][testX][1] = undefined;
			}
			if (theBlockType == 2) {
				for (l=0; l<block2Type.length; l += 2) {
					levelData[testY+block2Type[l+1]][testX+block2Type[(l)]][0] = 0;
					levelData[testY+block2Type[l]][testX+block2Type[(l+1)]][1] = undefined;
				}
			}
			if (theBlockType == 3) {
				for (l=0; l<block3Type.length; l += 2) {
					levelData[testY+block3Type[l+1]][testX+block3Type[(l)]][0] = 0;
					levelData[testY+block3Type[l]][testX+block3Type[(l+1)]][1] = undefined;
				}
			}
			if (theBlockType == 4) {
				for (l=0; l<block4Type.length; l += 2) {
					levelData[testY+block4Type[l+1]][testX+block4Type[(l)]][0] = 0;
					levelData[testY+block4Type[l]][testX+block4Type[(l+1)]][1] = undefined;
				}
			}
			//levelData[testY][testX][0] = 0;                                                                                      
			//levelData[testY][testX][1] = undefined;
			lastX = testClip._x;
			lastY = testClip._y;
			//yMouseOffset = testClip._y-_ymouse;
			return;
		}
	}
}
onMouseDown = function () {
	trace(gameState);
	if (gameState == "wait for users click") {
		trace("mouse pressed");
		gameState = "user is dragging";
		// find if player has clicked on a block, if so then start the dragging mode of that block
		// go through all bricks and find which one player has clicked on
		findBlockUserIsClicking();
	}
};
onMouseUp = function () {
	if (gameState == "user is dragging") {
		gameState = "wait for users click";
		// make block snap to the nearest 50 x 50
		testX = findTheXLocation(testClip._x+25);
		testY = findTheYLocation(testClip._y+25);
		// set the block in the grid
		// release the block from the grid
		// dop it based on the type of block it is
		if (theBlockType == 1) {
			levelData[testY][testX][0] = 1;
			levelData[testY][testX][1] = t;
		}
		if (theBlockType == 2) {
			for (l=0; l<block2Type.length; l += 2) {
				levelData[testY+block2Type[l+1]][testX+block2Type[(l)]][0] = 1;
				levelData[testY+block2Type[l]][testX+block2Type[(l+1)]][1] = t;
			}
		}
		if (theBlockType == 3) {
			for (l=0; l<block3Type.length; l += 2) {
				levelData[testY+block3Type[l+1]][testX+block3Type[(l)]][0] = 1;
				levelData[testY+block3Type[l]][testX+block3Type[(l+1)]][1] = t;
			}
		}
		if (theBlockType == 4) {
			for (l=0; l<block4Type.length; l += 2) {
				levelData[testY+block4Type[l+1]][testX+block4Type[(l)]][0] = 1;
				levelData[testY+block4Type[l]][testX+block4Type[(l+1)]][1] = t;
			}
		}
		//levelData[testY][testX][0] = 1;                                                                                  
		//levelData[testY][testX][1] = t;
		testClip._x = testX*50+40;
		testClip._y = testY*50+40;
		// test if level has been solved.]
		moves++;
		movesTextBox.text = moves;
		if (testClip.typeOfBlock == 4) {
			if (testX == solvedX && testY == solvedY) {
				trace("level solved");
				trace("king peice");
				gameState = "level solved";
				//solvedX;
			}
		}
	}
};
function findTheXLocation(tempN) {
	return (Math.floor((tempN-40)/50));
}
function findTheYLocation(tempN) {
	return (Math.floor((tempN-40)/50));
}
function setupLevel() {
	moves = 0;
	solvedX = 2;
	solvedY = 1;
	//trace(gameState)
	// set up grid
	gridXOffset = 40;
	gridYOffset = 40;
	gridWidth = 4;
	gridHeight = 4;
	//trace("setup level");
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
			levelData[i][j][0] = 0;
			arrayNum++;
		}
	}
	// attach blocks
	// clock list vars go like this - type,x,y - NOTES: x and y are based on the grid, they get times by 50 when putting the blocks down
	//blockList = new Array(1, 1, 0, 2, 4, 2);
	//blockList.push(3, 2, 4);
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
	// block type 2
	// means 1 block
	block1Type = new Array(0, 0);
	// means 2 blocks, one on top of the other
	block2Type = new Array(0, 0, 0, 1);
	// means 2 blocks, side by side
	block3Type = new Array(0, 0, 1, 0);
	// L shape to the right
	block4Type = new Array(0, 0, 1, 0, 0, 1, 1, 1);
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
		t._x = blockx*50+40;
		//trace(t.x);
		t.y = blocky*50;
		t._y = blocky*50+40;
		blockNumber++;
		blockNameArray.push(t);
		// set all the parts into level data that are part of that block
		if (typeOfBlock == 1) {
			levelData[blocky][blockx][0] = 1;
			levelData[blocky][blockx][1] = t;
		}
		if (typeOfBlock == 2) {
			for (l=0; l<block2Type.length; l += 2) {
				levelData[blocky+block2Type[l+1]][blockx+block2Type[(l)]][0] = 1;
				levelData[blocky+block2Type[l]][blockx+block2Type[(l+1)]][1] = t;
			}
		}
		if (typeOfBlock == 3) {
			for (l=0; l<block3Type.length; l += 2) {
				levelData[blocky+block3Type[l+1]][blockx+block3Type[(l)]][0] = 1;
				levelData[blocky+block3Type[l]][blockx+block3Type[(l+1)]][1] = t;
			}
		}
		if (typeOfBlock == 4) {
			for (l=0; l<block4Type.length; l += 2) {
				levelData[blocky+block4Type[l+1]][blockx+block4Type[(l)]][0] = 1;
				levelData[blocky+block4Type[l]][blockx+block4Type[(l+1)]][1] = t;
			}
		}
	}
	gameState = "wait for users click";
}
setupLevel();
gameLoop = function () {
	gameStateTextBox.text = gameState;
	//trace(gameState) 
	switch (gameState) {
	case "playing" :
		break;
	case "waiting for users click" :
		break;
	case "user is dragging" :
		// find the directiojns the user is draggin in
		// test if this block can move into the position in the direction of the users mouse
		testBlocksMove();
		break;
	case "level solved" :
		showWord("LEVEL COMPLETE");
		trace(gameState);
		gameState = "level complete wait";
		break;
	}
};
gameTimeDelay = 32;
theGameLoop = setInterval(this, "gameLoop", gameTimeDelay);
