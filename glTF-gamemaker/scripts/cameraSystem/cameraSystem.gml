
/**
 * run draw code at transformed coords, corrects for +Yup rotation.
 * useful for drawing models "side on" so the default room view roughly maps to what you see.
 * for more rotation options use drawTransformed3D
 * @param {real} px x position
 * @param {real} py y position
 * @param {real} pz z position (basically depth)
 * @param {real} rot rotation about z-axis (basically image_angle)
 * @param {real} scale uniform scaling
 * @param {function} drawCode function containing draw code to run with this transform applied
 */
function drawTransformed(px, py, pz, rot, scale, drawCode=function(){}) {
	var m = matrix_build(px, py, pz, 0, 180, rot+180, scale, scale, scale);
	matrix_set(matrix_world, m);
	drawCode();
	setIdentity();
}

/**
 * drawTransformed() with more rotation options, corrects for +Yup rotation
 * @param {real} px x position
 * @param {real} py y position
 * @param {real} pz z position
 * @param {real} rx rotation about x-axis
 * @param {real} ry rotation about y-axis
 * @param {real} rz rotation about z-axis
 * @param {real} scale uniform scaling
 * @param {function} drawCode function containing draw code to run with this transform applied
 */
function drawTransformed3D(px, py, pz, rx, ry, rz, scale, drawCode=function(){}) {
	var m = matrix_build(px, py, pz, rx, ry+180, rz+180, scale, scale, scale);
	matrix_set(matrix_world, m);
	drawCode();
	setIdentity();
}

/// return to default camera view coords
function setIdentity() {
	static I = matrix_build_identity();
	matrix_set(matrix_world, I);
}

#macro MENU_BAR_HEIGHT (32)
/**
 * resize the game window and application surface
 * @param {real} w width
 * @param {real} h height
 * @param {real} [pxScale] integer pixel scaling of window. by default, scales window until it fits in current display
 */
function resizeScreen(w, h, pxScale=999) {
	var minScale = 1;
	var maxScale = min(display_get_width()/w, (display_get_height()-MENU_BAR_HEIGHT)/h);
	
	pxScale = floor(clamp(pxScale, minScale, maxScale));
	
	window_set_size(w*pxScale, h*pxScale);
	surface_resize(application_surface, w, h);
}
