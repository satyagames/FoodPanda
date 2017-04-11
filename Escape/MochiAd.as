/*
    MochiAds.com ActionScript 2 code, version 2.3

    Flash movies should be published for Flash 7 or later.

    Copyright (C) 2006-2007 Mochi Media, Inc. All rights reserved.
*/

class MochiAd {
    static function getVersion():String {
        return "2.3";
    }

    static function showPreGameAd(options:Object):Void {
        /*
            This function will stop the clip, load the MochiAd in a
            centered position on the clip, and then resume the clip
            after a timeout or when this movie is loaded, whichever
            comes first.

            options:
                An object with keys and values to pass to the server.
                These options will be passed to MochiAd.load, but the
                following options are unique to showPreGameAd.

                clip is a MovieClip reference to place the ad in
                (default: _root).

                no_bg disables the ad's background entirely when set to true
                (default: false)

                color is the color of the preloader bar
                as a number (default: 0xFF8A00)

                background is the inside color of the preloader
                bar as a number (default: 0xFFFFC9)

                outline is the outline color of the preloader
                bar as a number (default: 0xD58B3C)

                fadeout_time is the number of milliseconds to
                fade out the ad upon completion (default: 250).

                ad_started is the function to call when the ad
                has started
                (default: function ():Void { this.clip.stop() }).

                ad_finished is the function to call when the ad
                has finished
                (default: function ():Void { this.clip.play() }).

                ad_failed is called if an ad can not be displayed,
                this is usually due to the user having ad blocking
                software installed. If it is called, then it is called
                before ad_finished.
                (default: function ():Void { }).

                ad_loaded is called just before an ad is displayed
                with the width and height of the ad. If it is called,
                it is called after ad_started.
                (default: function(width:Number, height:Number):Void { }).
        */
        var DEFAULTS = {
            clip: _root,
            ad_timeout: 3000,
            fadeout_time: 250,
            regpt: "o",
            method: "showPreloaderAd",
            color: 0xFF8A00,
            background: 0xFFFFC9,
            outline: 0xD58B3C,
            ad_started: function ():Void { this.clip.stop(); },
            ad_finished: function ():Void { this.clip.play(); },
            ad_failed: function ():Void { trace("[MochAd] Couldn't load an ad, make sure that your game's local security sandbox is configured for Access Network Only and that you are not using ad blocking software"); },
            ad_loaded: function (width:Number, height:Number):Void { }
        };
        options = MochiAd._parseOptions(options, DEFAULTS);
    
        if ("5cc6f7dfb67f2f08341c831480f7c2a7".length == 0) {
            options.ad_started();
            options.ad_finished();
            return;
        }

        var clip = options.clip;
        var ad_msec = 11000;
        var ad_timeout = options.ad_timeout;
        delete options.ad_timeout;
        var fadeout_time = options.fadeout_time;
        delete options.fadeout_time;

        if (!MochiAd.load(options)) {
            options.ad_failed();
            options.ad_finished();
            return;
        }

        options.ad_started();
        
        var mc = clip._mochiad;
        mc.onUnload = function () {
            options.ad_finished();
        };

        /* Center the clip */
        var wh = MochiAd._getRes(options);
        var w = wh[0];
        var h = wh[1];
        mc._x = w * 0.5;
        mc._y = h * 0.5;
        
        var chk = mc.createEmptyMovieClip("_mochiad_wait", 3);
        chk._x = w * -0.5;
        chk._y = h * -0.5;

        var bar = chk.createEmptyMovieClip("_mochiad_bar", 4);
        bar._x = 10;
        bar._y = h - 20;

        var bar_color = options.color;
        delete options.color;
        var bar_background = options.background;
        delete options.background;
        var bar_outline = options.outline;
        delete options.outline;

        var backing = bar.createEmptyMovieClip("_outline", 1);
        backing.beginFill(bar_background);
        backing.moveTo(0, 0);
        backing.lineTo(w - 20, 0);
        backing.lineTo(w - 20, 10);
        backing.lineTo(0, 10);
        backing.lineTo(0, 0);
        backing.endFill();

        var inside = bar.createEmptyMovieClip("_inside", 2);
        inside.beginFill(bar_color);
        inside.moveTo(0, 0);
        inside.lineTo(w - 20, 0);
        inside.lineTo(w - 20, 10);
        inside.lineTo(0, 10);
        inside.lineTo(0, 0);
        inside.endFill();
        inside._xscale = 0;

        var outline = bar.createEmptyMovieClip("_outline", 3);
        outline.lineStyle(0, bar_outline, 100);
        outline.moveTo(0, 0);
        outline.lineTo(w - 20, 0);
        outline.lineTo(w - 20, 10);
        outline.lineTo(0, 10);
        outline.lineTo(0, 0);

        chk.ad_msec = ad_msec;
        chk.ad_timeout = ad_timeout;
        chk.started = getTimer();
        chk.showing = false;
        chk.last_pcnt = 0.0;
        chk.fadeout_time = fadeout_time;
        chk.fadeFunction = function () {
            var p = 100 * (1 - 
                ((getTimer() - this.fadeout_start) / this.fadeout_time));
            if (p > 0) {
                this._parent._alpha = p;
            } else {
                var _clip = this._parent._parent;
                MochiAd.unload(_clip);
                delete this.onEnterFrame;
            }
        };

        mc.lc.adLoaded = options.ad_loaded;

        mc.lc.adjustProgress = function (msec:Number):Void {
            var _chk = this.mc._mochiad_wait;
            _chk.server_control = true;
            _chk.started = getTimer();
            _chk.ad_msec = msec;
        };

        chk.onEnterFrame = function ():Void {
            var _clip = this._parent._parent;
            var ad_clip = this._parent._mochiad_ctr;
            var elapsed = getTimer() - this.started;
            var finished = false;
            var clip_total = _clip.getBytesTotal();
            var clip_loaded = _clip.getBytesLoaded();
            var clip_pcnt = (100.0 * clip_loaded) / clip_total;
            var ad_pcnt = (100.0 * elapsed) / chk.ad_msec;
            var _inside = this._mochiad_bar._inside;
            var pcnt = Math.min(100.0, Math.min((clip_pcnt || 0.0), ad_pcnt));
            pcnt = Math.max(this.last_pcnt, pcnt);
            this.last_pcnt = pcnt;
            _inside._xscale = pcnt;
            
            if (!chk.showing) {
                var total = ad_clip.getBytesTotal();
                if (total > 0 || typeof(total) == "undefined") {
                    chk.showing = true;
                    chk.started = getTimer();
                } else if (elapsed > chk.ad_timeout) {
                    options.ad_failed();
                    finished = true;
                }
            }
            if (elapsed > chk.ad_msec) {
                finished = true;
            }
            if (clip_total > 0 && clip_loaded >= clip_total && finished) {
                if (this.server_control) {
                    delete this.onEnterFrame;
                } else {
                    this.fadeout_start = getTimer();
                    this.onEnterFrame = chk.fadeFunction;
                }
            }
        };
    }
    
    static function showInterLevelAd(options:Object):Void {
        /*
            This function will stop the clip, load the MochiAd in a
            centered position on the clip, and then resume the clip
            after a timeout.

            options:
                An object with keys and values to pass to the server.
                These options will be passed to MochiAd.load, but the
                following options are unique to showInterLevelAd.

                clip is a MovieClip reference to place the ad in
                (default: _root).

                no_bg disables the ad's background entirely when set to true
                (default: false)

                fadeout_time is the number of milliseconds to
                fade out the ad upon completion (default: 250).

                ad_started is the function to call when the ad
                has started (may not get called if network down)
                (default: function ():Void { this.clip.stop() }).

                ad_finished is the function to call when the ad
                has finished or could not load
                (default: function ():Void { this.clip.play() }).

                ad_failed is called if an ad can not be displayed,
                this is usually due to the user having ad blocking
                software installed. If it is called, then it is called
                before ad_finished
                (default: function ():Void {}).

                ad_loaded is called just before an ad is displayed
                with the width and height of the ad. If it is called,
                then it is called after ad_started
                (default: function(width:Number, height:Number):Void { }).
        */
        var DEFAULTS = {
            clip: _root,
            ad_timeout: 2000,
            fadeout_time: 250,
            regpt: "o",
            method: "showTimedAd",
            ad_started: function ():Void { this.clip.stop(); },
            ad_finished: function ():Void { this.clip.play(); },
            ad_failed: function ():Void { trace("[MochAd] Couldn't load an ad, make sure that your game's local security sandbox is configured for Access Network Only and that you are not using ad blocking software"); },
            ad_loaded: function (width:Number, height:Number):Void { }
        };
        options = MochiAd._parseOptions(options, DEFAULTS);

        var clip = options.clip;
        var ad_msec = 11000;
        var ad_timeout = options.ad_timeout;
        delete options.ad_timeout;
        var fadeout_time = options.fadeout_time;
        delete options.fadeout_time;

        if (!MochiAd.load(options)) {
            options.ad_failed();
            options.ad_finished();
            return;
        }

        options.ad_started();
        
        var mc = clip._mochiad;
        mc.onUnload = function () {
            options.ad_finished();
        };

        /* Center the clip */
        var wh = MochiAd._getRes(options);
        var w = wh[0];
        var h = wh[1];
        mc._x = w * 0.5;
        mc._y = h * 0.5;
        
        var chk = mc.createEmptyMovieClip("_mochiad_wait", 3);
        chk.ad_msec = ad_msec;
        chk.ad_timeout = ad_timeout;
        chk.started = getTimer();
        chk.showing = false;
        chk.fadeout_time = fadeout_time;
        chk.fadeFunction = function () {
            var p = 100 * (1 - 
                ((getTimer() - this.fadeout_start) / this.fadeout_time));
            if (p > 0) {
                this._parent._alpha = p;
            } else {
                var _clip = this._parent._parent;
                MochiAd.unload(_clip);
                delete this.onEnterFrame;
            }
        };

        mc.lc.adLoaded = options.ad_loaded;

        mc.lc.adjustProgress = function (msec:Number):Void {
            var _chk = this.mc._mochiad_wait;
            _chk.server_control = true;
            _chk.started = getTimer();
            _chk.ad_msec = msec - 250;
        };

        chk.onEnterFrame = function ():Void {
            var ad_clip = this._parent._mochiad_ctr;
            var elapsed = getTimer() - this.started;
            var finished = false;
            if (!chk.showing) {
                var total = ad_clip.getBytesTotal();
                if (total > 0 || typeof(total) == "undefined") {
                    chk.showing = true;
                    chk.started = getTimer();
                } else if (elapsed > chk.ad_timeout) {
                    options.ad_failed();
                    finished = true;
                }
            }
            if (elapsed > chk.ad_msec) {
                finished = true;
            }
            if (finished) {
                if (this.server_control) {
                    delete this.onEnterFrame;
                } else {
                    this.fadeout_start = getTimer();
                    this.onEnterFrame = this.fadeFunction;
                }
            }
        };

    }

   static function showTimedAd(options:Object):Void {
        /* Compatibility stub for MochiAd 1.5 terminology */
        trace("[MochiAd] DEPRECATED: showTimedAd was renamed to showInterLevelAd in 2.0");
        MochiAd.showInterLevelAd(options);
    }

   static function showPreloaderAd(options:Object):Void {
        /* Compatibility stub for MochiAd 1.5 terminology */
        trace("[MochiAd] DEPRECATED: showPreloaderAd was renamed to showPreGameAd in 2.0");
        MochiAd.showPreGameAd(options);
    }
 
    static function _allowDomains(server:String):String {
        var hostname = server.split("/")[2].split(":")[0];
        if (System.security) {
            if (System.security.allowDomain) {
                System.security.allowDomain("*");
                System.security.allowDomain(hostname);
            }
            if (System.security.allowInsecureDomain) {
                System.security.allowInsecureDomain("*");
                System.security.allowInsecureDomain(hostname);
            }
        }
        return hostname;
    }

    static function _loadCommunicator(options:Object):Object {
        var DEFAULTS = {
            clip: _root,
            com_server: "http://x.mochiads.com/com/1/",
            method: "loadCommunicator",
            depth: 10337,
            id: "_UNKNOWN_"
        };
        options = MochiAd._parseOptions(options, DEFAULTS);
        options.swfv = options.clip.getSWFVersion() || 6;
        options.mav = MochiAd.getVersion();

        var clip = options.clip;
        var clipname = '_mochiad_com_' + options.id;

        if (!MochiAd._isNetworkAvailable()) {
            return null;
        }
        
        if (clip[clipname]) {
            return clip[clipname].lc;
        }

        var server = options.com_server + options.id;
        MochiAd._allowDomains(server);
        delete options.id;
        delete options.com_server;

        var depth = options.depth;
        delete options.depth;
        var mc = clip.createEmptyMovieClip(clipname, depth);
        var lv = mc.createEmptyMovieClip("_mochiad_com", 1);
        for (var k:String in options) {
            lv[k] = options[k];
        }

        var lc = new LocalConnection();
        var name = [
            "", Math.floor((new Date()).getTime()), random(999999)
        ].join("_");
        lc.mc = mc;
        lc.name = name;
        lc.allowDomain = function (d:String):Boolean {
            return true;
        };
        lc.allowInsecureDomain = lc.allowDomain;
        lc.connect(name);
        mc.lc = lc;
        lv.lc = name;
        lc._id = 0;
        lc._queue = [];
        lc.rpcResult = function (cb_arg:String):Void {
            var cb:Number = parseInt(cb_arg);
            var cblst = this._callbacks[cb];
            if (!cblst) {
                return;
            }
            delete this._callbacks[cb];
            var args = [];
            for (var i = 2; i < cblst.length; i++) {
                args.push(cblst[i]);
            }
            for (var i = 1; i < arguments.length; i++) {
                args.push(arguments[i]);
            }
            var method = cblst[1];
            var obj = cblst[0];
            if (obj && typeof(method) == 'string') {
                method = obj[method];
            }
            if (method) {
                method.apply(obj, args);
            }
        }
        lc._didConnect = function (endpoint:Object):Void {
            this._endpoint = endpoint;
            var q = this._queue;
            delete this._queue;
            var ds = this.doSend;
            for (var i = 0; i < q.length; i++) {
                var item = q[i];
                ds.apply(this, item);
            }
        }
        lc.doSend = function (args:Object, cbobj:Object, cbfn:Object):Void {
            if (this._endpoint == null) {
                var qargs = [];
                for (var i = 0; i < arguments.length; i++) {
                    qargs.push(arguments[i]);
                }
                this._queue.push(qargs);
                return;
            }
            this._id += 1;
            var id = this._id;
            if (cbfn === undefined || cbfn === null) {
                cbfn = cbobj;
            }
            this._callbacks[id] = [cbobj, cbfn];
            var slc = new LocalConnection();
            var ss = slc.send(this._endpoint, 'rpc', id, args);
        }
        lc._callbacks = {};
        lc._callbacks[0] = [lc, '_didConnect'];
            
        lv.st = getTimer();
        lv.loadMovie(server + '.swf', "POST");
        
        return lc;
 
    }

    static function fetchHighScores(options:Object, callbackObj:Object, callbackMethod:String):Boolean {
        /*
            Fetch the high scores from MochiAds. Returns false if a connection
            to MochiAds can not be established due to the security sandbox.

            options:
                An object with keys and and values to pass to the
                server.

                id should be the unique identifier for this MochiAd.

            callback(scores):

                scores is an array of at most 50 high scores, highest score
                first, with a millisecond epoch timestamp (for the Date
                constructor).  [[name, score, timestamp], ...]
        */
        var lc = MochiAd._loadCommunicator({id: options.id});
        if (!lc) {
            return false;
        }
        var fncall = ['fetchHighScores', options];
        lc.doSend(['fetchHighScores', options], callbackObj, callbackMethod);
        return true;
    }


    static function sendHighScore(options:Object, callbackObj:Object, callbackMethod:String):Boolean {
        /*
            Send a high score to MochiAds. Returns false if a connection
            to MochiAds can not be established due to the security sandbox.

            options:
                An object with keys and and values to pass to the
                server.

                id should be the unique identifier for this MochiAd.

                name is the name to be associated with the high score, e.g.
                "Player Name"

                score is the value of the high score, e.g. 100000.

            callback(scores, index):

                scores is an array of at most 50 high scores, highest score
                first, with a millisecond epoch timestamp (for the Date
                constructor).  [[name, score, timestamp], ...]

                index is the array index of the submitted high score in
                scores, or -1 if the submitted score did not rank top 50.
        */
        var lc = MochiAd._loadCommunicator({id: options.id});
        if (!lc) {
            return false;
        }
        var fncall = ['sendHighScore', options];
        lc.doSend(['sendHighScore', options], callbackObj, callbackMethod);
        return true;
    }

    static function load(options:Object):Object {
        /*
            Load a MochiAd into the given MovieClip
            
            options:
                An object with keys and values to pass to the server.

                clip is a MovieClip reference to place the ad in
                (default: _root).

                id should be the unique identifier for this MochiAd.

                server is the base URL to the MochiAd server.

                res is the resolution of the container clip or movie
                as a string, e.g. "500x500"
        */
        var DEFAULTS = {
            clip: _root,
            server: "http://x.mochiads.com/srv/1/",
            method: "load",
            depth: 10333,
            id: "_UNKNOWN_"
        };
        options = MochiAd._parseOptions(options, DEFAULTS);
        options.swfv = options.clip.getSWFVersion() || 6;
        options.mav = MochiAd.getVersion();

        var clip = options.clip;

        if (!MochiAd._isNetworkAvailable()) {
            return null;
        }
        
        if (clip._mochiad_loaded) {
            return null;
        }

        var depth = options.depth;
        delete options.depth;
        var mc = clip.createEmptyMovieClip("_mochiad", depth);
        
        var wh = MochiAd._getRes(options);
        options.res = wh[0] + "x" + wh[1];

        options.server += options.id;
        delete options.id;

        clip._mochiad_loaded = true;

        var lv = mc.createEmptyMovieClip("_mochiad_ctr", 1);
        for (var k:String in options) {
            lv[k] = options[k];
        }

        var server = lv.server;
        delete lv.server;
        var hostname = MochiAd._allowDomains(server);

        mc.onEnterFrame = function ():Void {
            if (this._mochiad_ctr._url != this._url) {
                this.onEnterFrame = function () {
                    if (!this._mochiad_ctr) {
                        delete this.onEnterFrame;
                        MochiAd.unload(this._parent);
                    };
                };
            }
        };

        var lc = new LocalConnection();
        var name = [
            "", Math.floor((new Date()).getTime()), random(999999)
        ].join("_");
        lc.mc = mc;
        lc.name = name;
        lc.hostname = hostname;
        lc.allowDomain = function (d:String):Boolean {
            return true;
        };
        lc.allowInsecureDomain = lc.allowDomain;
        lc.connect(name);
        mc.lc = lc;
        lv.lc = name;
            
        lv.st = getTimer();
        lv.loadMovie(server + '.swf', "POST");
        
        return mc;
    }

    static function unload(clip:Object):Boolean {
        /*
            Unload a MochiAd from the given MovieClip
            
                clip:
                    a MovieClip reference (e.g. _root.myBanner)
        */
        if (typeof(clip) == "undefined") {
            clip = _root;
        }
        if (clip.clip && clip.clip._mochiad) {
            clip = clip.clip;
        }
        if (!clip._mochiad) {
            return false;
        }
        clip._mochiad.removeMovieClip();
        delete clip._mochiad_loaded;
        delete clip._mochiad;
        return true;
    }

    static function _isNetworkAvailable():Boolean {
        if (System.security) {
            var o:Object = System.security;
            if (o.sandboxType == "localWithFile") {
                return false;
            }
        }
        return true;
    }
    
    static function _getRes(options:Object):Object {
        var b = options.clip.getBounds();
        var w = 0;
        var h = 0;
        if (typeof(options.res) != "undefined") {
            var xy = options.res.split("x");
            w = parseFloat(xy[0]);
            h = parseFloat(xy[1]);
        } else {
            w = b.xMax - b.xMin;
            h = b.yMax - b.yMin;
        }
        if (w == 0 || h == 0) {
            w = Stage.width;
            h = Stage.height;
        }
        return [w, h];
    }

    static function _parseOptions(options:Object, defaults:Object):Object {
        var optcopy = {};
        for (var k:String in defaults) {
            optcopy[k] = defaults[k];
        }
        if (options) {
            for (var k:String in options) {
                optcopy[k] = options[k];
            }
        }
        if (_root.mochiad_options) {
            var pairs = _root.mochiad_options.split("&");
            for (var i = 0; i < pairs.length; i++) {
                var kv = pairs[i].split("=");
                optcopy[unescape(kv[0])] = unescape(kv[1]);
            }
        }
        if (optcopy.id == 'test') {
            trace("[MochiAd] WARNING: Using the MochiAds test identifier, make sure to use the code from your dashboard, not this example!");
        }
        return optcopy;
    }

}
