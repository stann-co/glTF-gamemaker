World.exampleText = "animation tester";
World.debugTextDefault = "1-9 change animation";

var loaded = gltfLoad(exampleGltfSettings().testFile);

gltfListMeshes();

skinned = false;

testSkin = noone;
testMesh = noone;

size = undefined;

if (array_length(loaded.skinnedMeshes) > 0) {
	skinned = true;
	var name = loaded.skinnedMeshes[0];
	testSkin = new gltfSkinnedMesh(name);
	testSkin.update();
	testMesh = testSkin.skin.meshName;
	
	size = testSkin.getSize();
}
else {
	testMesh = loaded.meshes[0];
	size = gltfMeshSize(testMesh);
}

maxBones = 0;
anim = undefined;

x = 0;
y = 0;
z = 0;

draw_set_color(c_white);

scale = 512 / (max(size.x, size.y));

var center = gltfMeshMidpoint(testMesh);
center.scale(scale);

with (Camera) {
	reset();
	pos.x = center.x;
	pos.y = -center.y;
}

t = 0;

lastDigit = -1;

draw = function() {
	if (skinned) {
		testSkin.draw(exampleGltfSettings().defaultShader);
	}
	else {
		gltfDrawMesh(testMesh);
	}
};

getLastDigit = function() {
	if (keyboard_lastkey == -1) return -1;
	var lastkey = keyboard_lastchar;
	keyboard_lastkey = -1;

	var n = ord(lastkey)-ord("0");

	if (n >= 0 && n <= 9) {
		return n;
	}
	return -1;
};
