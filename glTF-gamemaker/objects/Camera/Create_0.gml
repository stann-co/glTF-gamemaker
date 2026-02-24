// ONLY ONE!
if (instance_number(Camera) > 1) {
	instance_destroy();
	exit;
}

pos = new vec4(0, 0, -1000);
//pos = new vec4(0, 0, -10);
dir = new vec4(0, 0.05, -sign(pos.z));

rot = 0;

reset = function() {
	pos.x = 0; pos.y = 0; pos.z = -1000;
	rot = 0;
};

up = new vec3();
setUp = function(_up="y", _sgn=1) {
	up.scale(0);
	up[$ _up] = sign(_sgn);
}
setUp("y", 1);

floorGrid = meshGrid(10, 10, c_white, 0.333);
