var ExpressInstall = function ():Void {
	// does the user need to update?
	this.needsUpdate = (_root.MMplayerType == undefined) ? false : true;
};
ExpressInstall.prototype = {init:function ():Boolean {
	if (this.needsUpdate) {
		this.loadUpdater();
		return true;
	} else {
		return false;
	}
}, loadUpdater:function ():Void {
	System.security.allowDomain("fpdownload.macromedia.com");
	// hope that nothing is at a depth of 10000000, you can change this depth if needed, but you want
	// it to be on top of your content if you have any stuff on the first frame
	this.updater = _root.createEmptyMovieClip("expressInstallHolder", 10000000);
	// register the callback so we know if they cancel or there is an error
	var _self = this;
	this.updater.installStatus = _self.onInstallStatus;
	this.hold = this.updater.createEmptyMovieClip("hold", 1);
	// can't use movieClipLoader because it has to work in 6.0.65
	this.updater.onEnterFrame = function():Void  {
		if (typeof this.hold.startUpdate == 'function') {
			_self.initUpdater();
			this.onEnterFrame = null;
		}
	};
	var cacheBuster:Number = Math.random();
	this.hold.loadMovie("http://fpdownload.macromedia.com/pub/flashplayer/update/current/swf/autoUpdater.swf?"+cacheBuster);
}, initUpdater:function ():Void {
	this.hold.redirectURL = _root.MMredirectURL;
	this.hold.MMplayerType = _root.MMplayerType;
	this.hold.MMdoctitle = _root.MMdoctitle;
	this.hold.startUpdate();
}, onInstallStatus:function (msg):Void {
	if (msg == "Download.Complete") {
		// Installation is complete. In most cases the browser window that this SWF
		// is hosted in will be closed by the installer or manually by the end user
	} else if (msg == "Download.Cancelled") {
		// The end user chose "NO" when prompted to install the new player
		// by default no User Interface is presented in this case. It is left up to
		// the developer to provide an alternate experience in this case
		// feel free to change this to whatever you want, js errors are sufficient for this example
		getURL("javascript:alert('This content requires a more recent version of the Macromedia Flash Player.')");
	} else if (msg == "Download.Failed") {
		// The end user failed to download the installer due to a network failure
		// by default no User Interface is presented in this case. It is left up to
		// the developer to provide an alternate experience in this case
		// feel free to change this to whatever you want, js errors are sufficient for this example
		getURL("javascript:alert('There was an error downloading the Flash Player update. Please try again later, or visit macromedia.com to download the latest version of the Flash plugin.')");
	}
}};
// initialize the ExpressInstall object
var ExpressInstall = new ExpressInstall();
// if the user needs to upgrade, show the 'start upgrade' button
if (ExpressInstall.needsUpdate) {
	ExpressInstall.init();
	// this is optional, you could also automatically start the
	// upgrade by calling ExpressInstall.init() here instead of the following lines
	// attach the custom upgrade message  ** NOTE: see notes in Upgrade Message movieclip re: types of content to use
	//var upgradeMsg = _root.attachMovie("upgradeMsg_src", "upgradeMsg", 1);
	//upgradeMsg._x = Stage.width/2;
	//upgradeMsg._y = Stage.height/2;
	// attach the button actions that will start the ExpresInstall updater
	//upgradeMsg.upgradeBtn.onRelease = function() {
		//ExpressInstall.init();
	//};
	// if expressinstall is invoked, stop the timeline.
	stop();
}
