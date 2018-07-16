dynamic class pointer extends MovieClip {
	var linkage:String;
	var isIn:Boolean;
	var updated:Boolean;
	var pointinterval;
	var Ptype; // is in or out. - as string;
	var owner; // the parent
	var line_mc:MovieClip;

	function pointer () {
		line_mc = this.createEmptyMovieClip("line_mc",this.getNextHighestDepth());
		line_mc.swapDepths(1);
		linkage="mouse";
		owner=this._parent.owner;
		setType(Ptype);
		updated=false;
	}
	
	function setType(what) {
		var tcolor = new Color(this["imp"]["interior"]);
		Ptype=what;
		if (what=="in") {
			tcolor.setRGB(0x00ff00); // green
			this["imp"]["arrow"].gotoAndStop(what);
		} else {
			tcolor.setRGB(0xff0000); // green
			this["imp"]["arrow"].gotoAndStop(what);
		}
		Ptype=what;
	}
		
	function RotateTo(tox,toy) {
		var d;
		d = new Object();
		d.x=-_x;
		d.y=-_y;
		this.localToGlobal(d);
		var xD = tox - d.x;
		var yD = -(toy - d.y);
		var c = Math.sqrt(xD*xD+yD*yD);
		var angle = Math.asin(xD/c) * 180/Math.PI ;
		if (yD <=0 && xD>=0){
			angle = 180 - angle;
		}else if (yD>0 && xD<0){
			angle = 360 + angle; 
		}else if (yD<0 && xD<0){
			angle = 180 - angle;	
		}
		this._rotation=angle;
	}
	
	function getXY(st) {
		var m;
		var g;
		g=targetPath(owner); // backup of owner.
        st=g+"."+st;
		m=new Object();
		m.x=0;
		m.y=-61;
		g = eval(st);
		g.localToGlobal(m);
		return m;
	}

	function point() {
		var d;
		d=new Object();
		d.x=0;
		d.y=0;
		d=getXY(linkage);
		RotateTo(d.x,d.y);
		dLine();
	}
	
	function activate() {
		if (!updated && linkage <> "mouse") {
			var o=eval(linkage);
			this.play();
			this["imp"]["arrow"].play();
			updated=true;
//			line_mc.clear;
			this.onEnterFrame = this.doEnterFrame;
			eval(this.owner+"."+o).activate();
		}
	}
	function deactivate() {
		if (updated) {
			var o=eval(linkage);
			this.gotoAndStop(2);
			this["imp"]["arrow"].gotoAndStop(Ptype);
			updated=false;
			this.onEnterFrame = null;
			dLine();
			eval(this.owner+"."+o).deactivate();
		}
	}

	function dLine() {
		if (Ptype == "out") {
			line_mc.clear();
			var s = new Object();
			s = getXY(linkage);
			this.globalToLocal(s);
			line_mc.lineStyle(1,0,70);
			line_mc.moveTo(0,-59);
			line_mc.lineTo(s.x,s.y);
		}
	}
		
	function setLink(where) {
		if (Ptype=="out") {
			linkage=where;
			point();
			var st=this._parent._name+"."+this._name;
			var o=eval(this.owner+"."+where);
			o.linkage=st; //.slice(8,st.length); // to remove the "_level0." header
			o.point();
			point();
			o.point();
			dLine();
		}
	}
	
	function doEnterFrame() {
		dLine();
		point();
	}
	
	function getVar(what) {
		// gets the variable value of the parent of the linked pointer....
		if (linkage <> "mouse") {
			var o;
			var s; 
			var d=linkage.split(".");
			s= targetPath(owner)+"."+d[0]+".info_mc."+what;
			o=eval(s);
			return (o);
		}
	}
	
	function getNext() {
		var o;
		o=this._parent._parent[linkage.substring(0, linkage.indexOf("."))];
		return o;
	}
}