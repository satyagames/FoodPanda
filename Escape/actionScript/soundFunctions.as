// play a sound
function playSound(temp) {
	trace("Playing sound - "+temp);
	switch (temp) {
	case "bounce" :
		a = random(3)+1;
		eval("bounce"+a+"Snd").start();
		break;
	case "hitbat" :
		a = random(2)+1;
		eval("hitbat"+a+"Snd").start();
		break;
	case "bonus" :
		bonusSnd.start();
		break;
	case "ballLost" :
		ballLostSnd.start();
		break;
	case "mouseOver" :
		mouseOverSnd.start();
		break;
	case "mouseDown" :
		mouseDownSnd.start();
		break;
	}
}
// set up sounds
function attachSoundFromLibrary(idname) {
	var mysoundobj = new Sound(this);
	mysoundobj.attachSound(idname);
	return mysoundobj;
}
music1 = attachSoundFromLibrary('music1.wav');
music2 = attachSoundFromLibrary('music2.wav');
music3 = attachSoundFromLibrary('music3.wav');
mouseOverSnd = attachSoundFromLibrary('mouseOver.wav');
mouseDownSnd = attachSoundFromLibrary('mouseDownSnd.wav');
gameovermusic = attachSoundFromLibrary('gameovermusic.wav');
intromusic = attachSoundFromLibrary('intromusic.wav');
optionsmusic = attachSoundFromLibrary('optionsmusic.wav');
gamefinishedmusic = attachSoundFromLibrary('gamefinishedmusic.wav');

// set up sound control functions
musicstate = storage.data.musicsetting;
if (musicstate == undefined || musicstate == 2) {
	musicstate = 1;
	storage.data.musicsetting = 1;
}
function stopMusic() {
	music1.stop();
	music2.stop();
	music3.stop();
	optionsmusic.stop();
	intromusic.stop();
	gameovermusic.stop();
	gamefinishedmusic.stop();
}
function musicOn() {
	// MUSIC HAS BEEN TURNED ON
	this.on_off.gotoAndStop(1);
	musicstate = 1;
	storage.data.musicsetting = 1;
	playMusic();
}
function musicOff() {
	// MUSIC HAS BEEN TURNED OFF
	stopMusic();
	this.on_off.gotoAndStop(2);
	musicstate = 0;
	storage.data.musicsetting = 0;
}
function playmusic() {
	if (musicstate == 1) {
		stopMusic();
		// Play the right music for which scene the game is in
		switch (gameScene) {
		case "INTRO" :
			intromusic.start(0, 90);
			break;
		case "GAME" :
			// play the right track for the right level
			b = level-((int(level/3))*3);
			switch (b) {
			case 0 :
				music1.start(0, 30);
				break;
			case 1 :
				music2.start(0, 30);
				break;
			case 2 :
				music3.start(0, 30);
				break;
			default :
				music1.start(0, 30);
				break;
			}
			break;
		case "GAME OVER" :
			gameovermusic.start(0, 9);
			break;
		case "OPTIONS" :
			optionsmusic.start(0, 90);
			break;
		case "HOW TO PLAY" :
			optionsmusic.start(0, 90);
			break;
		case "GAME FINISHED" :
			gamefinishedmusic.start(0, 90);
			break;
		default :
			break;
		}
	}
}
