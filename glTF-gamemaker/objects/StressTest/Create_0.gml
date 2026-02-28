testSkin = noone;
positions = [ ];
scale = 1;

var w = 3000;

for (var i = 0; i < meshCount; i++) {
	positions[i] = new __gltfVec3(lerp(0, w, -1+random(2)), 0, lerp(0, w, -1+random(2)));
}

if (animateIndividually) {
	repeat(meshCount) {
		instance_create_depth(0, 0, 0, MeshTester);
	}

	var i = 0;
	with (MeshTester) {
		x = other.positions[i].x;
		z = other.positions[i].y;
		i++;
	}
}
else {
	var loaded = gltfLoad(exampleGltfSettings().testFile);
	testSkin = new gltfSkinnedMesh(loaded.skinnedMeshes[0]);
	testSkin.update();
	
	var size = testSkin.getSize();
	scale = 512 / (max(size.x, size.y));
}

t = 0;

game_set_speed(gamespeed_fps, 600);