function gltfSettings() {
	static s = {
		testRooms : [
			r01_gltfAnimations,
			r02_gltfWeights,
			r03_gltfBlending,
		],
		currentRoom : -1,
		
		//startRoom : r98_stress,
		
		defaultShader : shPSX,
		//defaultShader : shSkinnedMesh,
		
		
		testFile : "mikuleek.gltf",
		//testFile : "testfile5.gltf",
		//testFile : "cube.gltf",
		
		cullMode : cull_noculling, // generally want cull_clockwise for backface culling
		
		drawBones : false,
	};
	return s;
}

function gltfNextTestRoom() {
	var rooms = gltfSettings().testRooms;
	var current = (gltfSettings().currentRoom+1) mod array_length(rooms);
	gltfSettings().currentRoom = current;
	room_goto(rooms[current]);
}
