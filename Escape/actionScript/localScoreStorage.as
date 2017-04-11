// LOAD SAVED SCORE, LEVEL & MUSIC SETTINGS
storage = SharedObject.getLocal(gameName +"storage");
level = storage.data.uptolevel;
if (level == undefined) {
	storage.data.uptolevel = 1;
	level = 1;
}
yourhigh = storage.data.myhighscore;
if (yourhigh == undefined) {
	storage.data.myhighscore = 0;
	yourhigh = 0;
}
