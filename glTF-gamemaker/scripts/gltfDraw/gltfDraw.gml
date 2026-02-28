
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