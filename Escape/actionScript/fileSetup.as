// © 2006 Terry Paton
// terry@terrypaton.com
// www.terrypaton.com
this._lockroot = true;
var gameName:String = "centipede";
vNum = "1.0 b-1";
//
gameQuality = "AUTO";
fscommand("fullscreen", true);
// Set up right click menu
authorsSite = "http://www.terrypaton.com";
var menu_cm = new ContextMenu();
menu_cm.customItems.push(new ContextMenuItem(authorsSite, gameMenu));
function gameMenu(menu, obj) {
	getURL(_root.authorsSite, "_blank");
}
menu_cm.hideBuiltInItems();
_root.menu = menu_cm;
// running from legal location ?
legalDomain = "http://www.terrypaton.com";
gameLocation = _root._url.substr(0, legalDomain.length);
if (gameLocation != legalDomain) {
	//stop();
}
