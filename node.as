dynamic class node extends MovieClip {
	var Pmod;
	var Gmod;
	var Qtype;
	// How to descide wich node to go next
	// could be: "question" - seek the answer in the linked nodes
	// "condition" - if condition true, goto 1 else goto 2nd connector
	// "random"
	var condition;
	// for trashG/P write: " > 3" or " < 0.5"
	// always jump to first pointer;
	// if G/P with condition happens - jump to second pointer
	var answer;
	var ID;
	function node() {
	}

	function init(Pm, Gm, Qt, con, ans, WID) {
		Pmod = Pm;
		Gmod = Gm;
		Qtype = Qt;
		_parent.gotoAndStop(Qt);
		condition = con;
		answer = ans;
		ID = WID;
		this["ID_txt"].text = ID;
		this["title_txt"].text = Qt;
		if (Qt == "condition") {
			this["cond_txt"].text = con;
		} else if (Qt== "question") {
			this["cond_txt"].text = "";
		} else {
			this["cond_txt"].text = ans;
		}
		this["P_txt"].text = Pmod;
		this["G_txt"].text = Gmod;
	}
	function inbound(what,min,max){
		if (what > max) {
			what = max;
		} else if (what < min) {
			what = min;
		}
		return what;
	}
	
	function land(Q,sb) {
		if (sb) {this._parent.attachMovie("explain","exp1",21);}
		var st = "landed on " + Qtype + " node";
		if (answer <> "") {
			st += " with the keyword: " + answer;
		}
		if (Qtype == "question") {
			st += " that has "+_parent.Outs+" answers.";
		} else if (Qtype == "condition") {
			st += ": " + condition + ", where P="+_global.Pm+" and G="+_global.Gm;
		}
		this._parent["exp1"].startup(Q,st);

		if (_global.Pm > 0) {
			_global.Pm += Pmod * _global.Gm;
		} else {
			_global.Pm += Pmod * (1 / _global.Gm);
		}

		this.gotoAndStop(2);
		_global.Gm += Gmod;
		_global.Gm = inbound(_global.Gm,0.25,4);
		_global.Pm = inbound(_global.Pm,-21,21);
		return getNextNode(Q);
	}

	function getNextNode(Q) {
		var a;
		var o;
		switch (Qtype) {
		case "question" :
			for (var m=1; m<=_parent.Outs;++m){
				o= _parent["o"+m];
				a = o.getVar("answer");
				if (Q.indexOf(a) <> -1) {
					return o.getNext();
				}
			}
			trace ("random after false question");
		case "random" :
			var i = _parent.Outs;
			var m = (random(i) + 1);
			a = _parent["o" + m].getNext();
			return a;
			break;
		case "condition" :
			var d=condition.split(" ");
			switch (d[1]) {
				case ">" : if (eval("_global."+d[0]) > d[2]) {
						a = 1;
					} else {
						a = 2;
					}
					break;
				case "<" : if (eval("_global."+d[0]) < d[2]) {
						a = 1;
					} else {
						a = 2;
					}
					break;
				case "=" : if (eval("_global."+d[0]) == d[2]) {
						a = 1;
					} else {
						a = 2;
					}
					break;
			}
			o = _parent["o" + a].getNext();
			return o;
			if (o <> undefined) {
				break;
			}
		}
	}
	function leave() {
		this.gotoAndStop(1);
	}
}
