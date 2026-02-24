// note: actual controls are in World begin step event
shift = keyboard_check(vk_shift);

var lerpFactor = 1/5;
if (shift) {
	t = lerp(t, tMax, lerpFactor);
}
else {
	t = lerp(t, tMin, lerpFactor);
}

skin.animate(t);
