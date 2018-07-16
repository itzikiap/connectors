import mx.events.*
class mahshava extends MovieClip{
//declaring the function EventDispatcher uses	
	public function dispatchEvent () {}
	public function addEventListener () {}
	public function removeEventListener () {}
	
	var thought:String;
	var lifeLimit:Number; // 0 - no limit
	var cycle:Number;
	var moves:Number;
	var showBaloon:Boolean;
	var speed;
	static var thoughts:Number; // count how many touts symultanically
	var online:Boolean;
	var parentSTR; // NOT _parent!!!
	var parentOBJ; // NOT _parent!!!
	var Tstatus; // "landing" "going"
	var landPass;
	var nextRound; // for animation pourposes

	function mahshava() {
		EventDispatcher.initialize (this);
		landPass=-1; // for animation propouses - each pass take next action
		if (speed == 0) {
			speed = 6;
		}
		thoughts++;
		if (isNaN(lifeLimit)) {lifeLimit = 0};
		if (lifeLimit == -1) {lifeLimit = 0};
		cycle = 0;
		online=false;
	}
	
	function land() {
		switch (landPass) {
			case 0: 
				++landPass;
				Tstatus = "landing";
				gotoAndPlay("landing");
				if (((parentOBJ.info_mc.ID == 1) && (cycle > 0)) || ((cycle > lifeLimit) && (lifeLimit <> 0))) {
					Bye();
				}
				++cycle;
				nextRound = parentOBJ.land(thought,showBaloon);
				break;
			case 1: 
				break;
			case 2:
				++landPass;
				break;
			case 3: 
				++landPass;
				go(nextRound);
				break;
		}
	}
	
	function go(where) {
		Tstatus = "going"
		gotoAndPlay("going");
		parentOBJ.leave();
		setParent(where);
		landPass=0;
		moves++;
//		if (moves > lifeLimit) Bye();
	}

	function onEnterFrame() {
		if (!moveIt()) {
			land();
		}
	}
	
	function setParent(str){
		var s=str;
		if (str[0] == "_") {
			var d=str.split(".");
			var l=d.length-1;
			s="_root";
			var i;
			for (i=1;i<=l;i++) {
				if (s <> "") {s=s+"."}
				s=s+d[i];
			}
		}
		parentSTR = s;
		parentOBJ = eval(s);
	}
	
	function proccess() {
		//eval(parent).
	}
	
	function moveIt():Boolean {
		var s=new Object();
		s._x= (parentOBJ._x - _x) / speed;
		s._y= (parentOBJ._y - _y) / speed + 1;
		_x += s._x;
		_y += s._y;
		var xD = parentOBJ._x - _x;
		var yD = -(parentOBJ._y - _y);
		var c = Math.sqrt(xD*xD+yD*yD);
		var angle = Math.asin(xD/c) * 180/Math.PI ;
		if (yD <0 && xD>0){
			angle = 180 - angle;
		}else if (yD>0 && xD<0){
			angle = 360 + angle; 
		}else if (yD<0 && xD<0){
			angle = 180 - angle;	
		}
		this._rotation=angle;
		return ((Math.abs(s._x)+Math.abs(s._y)) /2 >= 1);
	}
	function getThought() {
		return thought;
	}
	
	function getXY(st) {
		var m;
//		var g;
//		g=targetPath(owner);
		var owner= new MovieClip();
		owner=_root;
//		st=st+"."+g;
		m=new Object();
		m.x=0;
		m.y=0;
		var d=new Array();
		d=st.split(".");
		var l=d.length-1;
		var s="";
		var i;
		for (i=1;i<=l;i++) {
			if (s <> "") {s=s+"."}
			s=s+d[i];
			m.x+=owner[s]._x;
			m.y+=owner[s]._y;
			owner=owner[s];
			s="";
		}
//owner=eval(g);
		return m;
	}

	function Bye() {
		thoughts--;
		this.removeMovieClip();
	}
	
// message dispatvhers
	function broadcast(what) {
		sending:Object = new Object();
		sending.target = this;
		sending.type = what;
//		sending.Thought = this.Thought
		dispatchEvent(sending);
	}
}