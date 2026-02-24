event_inherited();

World.exampleText = "bone weight tester";
World.debugTextDefault = "0-9 select bone\nmouse: rotate bone (X,Z axes)";

currentBone = -1;

// see comments in step event for alternate methods for animating procedurally
animateMethod = 2; // 1 or 2

if (skinned) {
	maxBones = testSkin.skin.bones;
	zrot = array_create(maxBones, 0);
	xrot = array_create(maxBones, 0);
	
	mousePoses = array_create(maxBones, undefined);
	poseData = array_create(maxBones, undefined);
	for (var i = 0; i < maxBones; i++) {
		mousePoses[i] = new poseTriple();
		poseData[i] = matrix_build_identity();
	}
}

uniforms = [
	new shaderUniformFloat(shMeshWeights, "uBoneID", [ currentBone ]),
];

draw = function() {
	if (skinned) {
		testSkin.draw(shMeshWeights, uniforms);
		testSkin.debugDrawBones();
	}
	else {
		drawMesh(testMesh);
	}
};
