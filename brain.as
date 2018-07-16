class brain extends MovieClip{
	var _anchore:Object;
	var _follow:Object;
	var _P:Number;
	var _G:Number;
	var _thoughts:Array;
	var _tNum:Number;
	var _FirstNewron;

	var thoughts_mc:MovieClip;
	function brain() {
		_anchore = new Object;
		_anchore._x = _x;
		_anchore._y = _y;
		_P=5;
		_G=2.5;
		_tNum=0;
		_thoughts = new Array();
		_FirstNewron="con1";
	}

	function NewThought(ts,sb,sp) {
		_tNum++;
		var tht_mc;
		tht_mc=this.attachMovie("thought","thought"+_tNum,this.getNextHighestDepth(),{thought:ts,showBaloon:sb,speed:sp});
		tht_mc.go(targetPath(this)+"."+_FirstNewron);
		_thoughts[_tNum]=tht_mc;
		_follow = tht_mc;
		thoughts_mc.form.newThought(tht_mc);
//		tht_mc.addEventListener(
//		_root.addThought(tht_mc,_tNum);

	}

	function getTNum() {
		return _tNum;
	}

	function setFollow(newFollow) {
		if (newFollow != "none") {
			_follow = newFollow;
		} else _follow = this;
	}
	function onEnterFrame() {
		var s = new Object();
		s._x = (-_follow._x - _x) / 2;
		s._y = (-_follow._y - _y) / 2;
		_x += s._x+_anchore._x/2;
		_y += s._y+_anchore._y/2;
	}

	function Zoom(where) {
		if (where == "in") {
			_xscale += 5;
			_yscale += 5;
		} else {
			_yscale -= 5;
			_xscale -= 5;
		}
	}
}