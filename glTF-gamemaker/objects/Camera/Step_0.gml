/// @desc camera input

var mv = new vec4();

if (keyboard_check(vk_up)) mv.y -= 1;
if (keyboard_check(vk_down)) mv.y += 1;
if (keyboard_check(vk_left)) mv.x -= 1;
if (keyboard_check(vk_right)) mv.x += 1;

var shift = keyboard_check(vk_shift);

var spd = 8;
if (!shift) {
	// move on plane perpendicular to camera
	pos.x += mv.x * spd;
	pos.y += mv.y * spd;
}
else {
	// rotate camera, move camera forward and back
	rot -= mv.x * spd/2;
	pos.z -= mv.y * spd;
}
