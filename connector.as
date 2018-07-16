class connector extends MovieClip {
	var Outs; // how much connectors do you have?
	var Ins;
	var prefix;// it uses this prefix to know where to connect. 
	var suffix; // it uses the suffix to know the subobject to connect
	var owner;// the referrence to the parent object
	var connectTo; 
	// i.e: connectTo=5 will connect to object "con5.i"
	var activated;
	var info_mc;
	
	function connector() {
		_alpha=40;
		prefix = "con";
		suffix = ".i";
		owner = this._parent;
		connectTo = 1;
		Outs=0;
		Ins=0;
		activated = false;
	}
	
	function init(con,ans,type,P,G){
		this.attachMovie("node","info_mc",this.getNextHighestDepth());
		var tID=this._name.substr(3, this._name.length-3);
//		var tID=parseInt(this._name[this._name.length-1]);
		info_mc.init(P,G,type,con,ans,tID);
		
	}
	
	function connectIt(where) {
		connectTo = where;
		var f=eval(this.owner+"."+prefix+where);
		var a=f.getFreeIn();
		++Outs;
		this.attachMovie("pointer","o"+Outs,this.getNextHighestDepth(),{Ptype:"out"});
		this["o"+Outs].setLink(getConnection()+a);
		
	}
	
	function getConnection() {
		return prefix+connectTo+suffix;
	}
	
	function getFreeIn() {
		++Ins;
		this.attachMovie("pointer","i"+Ins,this.getNextHighestDepth(),{Ptype:"in"});
		return this.Ins;
	}

	function land(what,sb) { // gets the thought
		var gto=this["info_mc"].land(what,sb);
		if (gto==undefined) {gto = targetPath(owner)+".con1"};
		_alpha = 100;
		for (var i=1;i<=Outs;i++) {
			this["o"+i].activate();
		}
		return gto;
	}
	
	function leave() {
		_alpha = 40;
		for (var i=1;i<=Outs;i++) {
			this["o"+i].deactivate();
		}
		info_mc.leave();
	}
}