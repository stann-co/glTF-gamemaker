// a

if (!skinned) exit;

var n = getLastDigit();

if (n >= 1 && n <= 9) {
	if (lastDigit != n) {
		lastDigit = n;
		testSkin.setAnimationIndex(n-1);
		hudDisplayText($"setting animation {n-1}: {testSkin.currentAnimation}");
	}
}

var mx = -180 + 360 * mouse_x / room_width;
var my = -180 + 360 * mouse_y / room_height;

//testSkin.position.x = lerp(0, 256, mx / 180);
//testSkin.rotation.y = lerp(0, 90, my / 180);

//testSkin.rotation.x += 0.2;

t += 1/60;
testSkin.animate(t);

/*

// if u just needed the position of a bone as a vec3
// this will give u a new vec3 that from the transform matrix (isnt updated automatically)
var armPosition = testSkin.getBonePosition("bArm.R");

*/