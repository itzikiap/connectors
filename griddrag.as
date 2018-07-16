MovieClip.prototype.grid=20;
MovieClip.prototype.dragint=0;

MovieClip.prototype.gridDrag=function() {
	this._x = this._parent._xmouse - (this._parent._xmouse % grid);
	this._y = this._parent._ymouse - (this._parent._ymouse % grid);
}
	
MovieClip.prototype.startGridDrag = function(ggrid) {
	if (ggrid <> 0) grid= ggrid;
	this.onEnterFrame = gridDrag;
}

MovieClip.prototype.stopGridDrag = function() {
	this.onEnterFrame = null; .startDrag
}