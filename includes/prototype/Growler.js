/**
 * k.Growler 1.0.0
 *
 * Dual licensed under the MIT (http://www.opensource.org/licenses/mit-license.php)
 * and GPL (http://www.opensource.org/licenses/gpl-license.php) licenses.
 *
 * Written by Kevin Armstrong <kevin@kevinandre.com>
 * Last updated: 2008.10.14
 *
 * Growler is a PrototypeJS based class that displays unobtrusive notices on a page. 
 * It functions much like the Growl (http://growl.info) available on the Mac OS X. 
 *
 * Changes in 1.0.1:
 * - 
 * May 2010 - Modified by Brice Michel - bmichel@appshore.com - AppShore Inc.
 */
 
window.Growler = window.Growler || {};
;(function(){

var noticeOptions = {
	header: 			false
	,speedin: 			0.3
	,speedout: 			0
	,outDirection: 		{ y: -20 }
	,life: 				5
	,sticky: 			false
	,className: 		""
};

var growlerOptions = {
	location: 			"TC"
	,width: 			"36%"
};
var IE = (Prototype.Browser.IE) ? parseFloat(navigator.appVersion.split("MSIE ")[1]) || 0 : 0;
function removeNotice(n, o){
	o = o || noticeOptions;
	new Effect.Parallel([
		new Effect.Move(n, Object.extend({ sync: true, mode: 'relative' }, o.outDirection)),
		new Effect.Opacity(n, { sync: true, to: 0 }) 
	], {
		duration: o.speedout
		,afterFinish: function(){
			try {
				var ne = n.down("div.notice-exit");
				if(ne != undefined){
					ne.stopObserving("click", removeNotice);
				}
				if(o.created && Object.isFunction(o.created)){
					n.stopObserving("notice:created", o.created);
				}
				if(o.destroyed && Object.isFunction(o.destroyed)){
					n.fire("notice:destroyed");
					n.stopObserving("notice:destroyed", o.destroyed);
				}
			} catch(e){}
			try {
				n.remove();
			} catch(e){}
		}
	});
}

function createNotice(growler, msg, options){
	var opt = Object.clone(noticeOptions);
	options = options || {};
	Object.extend(opt, options);
	var notice;
	if (opt.className != ""){
		notice = new Element("div", {"class": opt.className}).setStyle({display: "block", opacity: 0});
	} else {
		notice = new Element("div", {"class": "Growler-notice"}).setStyle({display: "block", opacity: 0});
	}
	if(opt.created && Object.isFunction(opt.created)){
		notice.observe("notice:created", opt.created);
	}
	if(opt.destroyed && Object.isFunction(opt.destroyed)){
		notice.observe("notice:destroyed", opt.destroyed);
	}
	if (opt.sticky){
		if (opt.stickyTitle == 'undefined')
			opt.stickyTitle = '';
		var noticeExit = new Element("div", {"class": "Growler-notice-exit", "title": opt.stickyTitle}).update("x");
		noticeExit.observe("click", function(){ removeNotice(notice, opt); });
		notice.insert(noticeExit);
	}
	if (opt.header)
		notice.insert(new Element("div", {"class": "Growler-notice-head"}).update(opt.header));
	notice.insert(new Element("div", {"class": "Growler-notice-body"}).update(msg));
	growler.insert(notice);
	new Effect.Opacity(notice, { to: 0.85, duration: opt.speedin });
	if (!opt.sticky){
		removeNotice.delay(opt.life, notice, opt);
	}
	notice.fire("notice:created");
	return notice;
}

Growler = Class.create({
	initialize: function(options){
		var opt = Object.clone(growlerOptions);
		options = options || {};
		Object.extend(opt, options);
		this.growler = new Element("div", { "class": "Growler", "id": "Growler" });
		this.growler.setStyle({ position: "fixed", padding: "2px", "width": opt.width, "z-index": "50000" });
		switch(opt.location){
			case "TL":
				this.growler.setStyle({top: 0, left: 0});
				break;
			case "TR":
				this.growler.setStyle({top: 0, right: 0});
				break;
			case "BL":
				this.growler.setStyle({bottom: 0, left: 0});
				break;
			case "BC":
				this.growler.setStyle({bottom: 0, left: "32%", width: "36%"});
				break;
			case "BR":
				this.growler.setStyle({bottom: 0, right: 0});
				break;
			case "TC":
			default:
				this.growler.setStyle({top: 0, left: "32%", width: "36%"});
				break;
		}
		this.growler.wrap( document.body );		
	}
	,growl: function(msg, options, style) {
		var n = createNotice(this.growler, msg, options);
		if( style )
			n.setStyle(style);
		return n;		
	}
	,error: function(msg){
		var n = createNotice(this.growler, msg, {sticky:true});
		n.setStyle({ backgroundColor: 'red', color: 'white', textAlign: 'center'});
		return n;		
	}
	,link: function(msg){
		var n = createNotice(this.growler, msg, {sticky:true});
		n.setStyle({ backgroundColor: 'gold', textAlign: 'center'});
		return n;		
	}	
	,nobox: function(msg){
		var n = createNotice(this.growler, msg);
		n.setStyle({ backgroundColor: 'lightgrey', textAlign: 'center'});
		return n;		
	}
	,notice: function(msg){
		var n = createNotice(this.growler, msg);
		n.setStyle({ backgroundColor: 'limegreen', textAlign: 'center'});
		return n;		
	}
	,warning: function(msg){
		var n = createNotice(this.growler, msg);
		n.setStyle({ backgroundColor: 'gold', textAlign: 'center'});
		return n;		
	}
	,ungrowl: function(n, o){
		removeNotice(n, o);
	}
});

})();
