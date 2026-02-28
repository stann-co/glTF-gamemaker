if (!skinned) exit;

var n = getLastDigit();

if (n >= 0 && n <= 9) {
	if (lastDigit != n) {
		lastDigit = n;
		currentBone = n;
		uniforms[0].setValues([ n ]);
		hudDisplayText(string_ext("setting current bone: {0}", [ n ]));
	}
}

var mx = -180 + 360 * mouse_x / room_width;
var my = -180 + 360 * mouse_y / room_height;

if (currentBone >= 0 && currentBone < maxBones) {
	zrot[currentBone] = mx;
	xrot[currentBone] = my;
	
	// 1st method: passing array of poseTriples into animateBlended
	// this involves a lot more struct calls so will be slower
	// you can pass quaternions directly into poseTriple so that may be desired
	// and this method also keeps T,R,S transforms separate
	// which is important for keeping animations that work on different bones separate
	// when blending animations together
	if (animateMethod == 1) {
		var pose = mousePoses[currentBone];
		pose.R = __gltfAngleToQuaternion(my, 0, mx);
		testSkin.animateBlended(mousePoses);
	}

	// 2nd method: passing array of matrices into update() - more direct so faster
	// however animations will not blend properly
	if (animateMethod == 2) {
		// these two matrix building methods are equivalent
		var m = matrix_build(0, 0, 0, xrot[currentBone], 0, zrot[currentBone], 1, 1, 1);
		array_copy(poseData[currentBone], 0, m, 0, 16);
		testSkin.update(poseData);
		
		// you could also use the pose data from method 1 and pass this into update()
		// more struct calls, but could be easier to read
		//array_copy(poseData[currentBone], 0, pose.toMatrix(), 0, 16);
	}
}
