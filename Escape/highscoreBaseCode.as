
function setupHighscoreSubmission() {
	submitScoreBtnClip.onRelease = function() {
		_darkener = attachMovie("darkener", "darkener", 100);
		
		_darkener.stopper.useHandCursor = false;
		
		var o:Object = { n: [], f: function (i:Number,s:String):String { if (s.length == 16) return s; return this.f(i+1,s + this.n[i].toString(16));}};
var boardID:String = o.f(0,"");
mochi.as2.MochiScores.showLeaderboard({boardID:boardID, score:score, onClose:function () {
removeDarkener();
}, onError:function () {
removeDarkener();
}});
		//mochi.as2.MochiScores.showLeaderboard({boardID:"", onClose:function () {
	//removeDarkener();
	//},onError:function () {
	//removeDarkener();
	//}, score:score});
		submitScoreBtnClip._visible = false;
	};
}


function showHighscores() {
	_darkener = attachMovie("darkener", "darkener", 1000);
	
	_darkener.stopper.useHandCursor = false;
	
	var o:Object = { n: [], f: function (i:Number,s:String):String { if (s.length == 16) return s; return this.f(i+1,s + this.n[i].toString(16));}};
var boardID:String = o.f(0,"");
mochi.as2.MochiScores.showLeaderboard({boardID: boardID, onClose:function () {
	removeDarkener();
	},onError:function () {
	removeDarkener();
	}});
	
	
}

_global.removeDarkener = function () {
	trace("REMOVE THE CLIP")
	removeMovieClip(_darkener);
}

 function onConnectError(status:String) {
	// handle error here...
	removeDarkener()
}