class explain extends MovieClip {
	var _title;
	var _explenation;
	var _scale;
	var _swing;
	var baloon_mc:MovieClip;
	var nowscale;
	var intP;
	function explain() {
		_scale = 100; //percent
		_swing = random(23);
		baloon_mc._alpha = 0;
	}
	
	function startup(mtitle,mexplan) {
		baloon_mc.title_txt.text=mtitle;
		baloon_mc.explan_txt.text=mexplan;
		_title=mtitle;
		_explenation=mexplan;
		baloon_mc._height = _height*_scale/100;
		baloon_mc._width = _width*_scale/100;
		nowscale = 1;
		this.onEnterFrame = doStart;
	}
	
	function doStart() {
		baloon_mc._alpha = nowscale;
		baloon_mc._y = _y-nowscale/2;
		nowscale += 10;
		if (nowscale >= 101) {
			nowscale=0;
			this.onEnterFrame = doWait;
		}
	}
	
	function doWait() {
		baloon_mc._x = this._x+_swing*Math.cos(nowscale*3.1415/180);
		baloon_mc._y = this._y-50+_swing*Math.sin(nowscale*3.1415/180);
		nowscale += 10;
		if (nowscale > 360) {
			nowscale = 0;
			if (random(10) < 7) {
				this.onEnterFrame = doFinish;
			}
		}
	}

	function doFinish() {
		baloon_mc._alpha = 100-nowscale;
		baloon_mc._y = _y-nowscale;
		nowscale+=10;
		if (nowscale >= 101) {
			this.removeMovieClip;
		}
	}
}
		
