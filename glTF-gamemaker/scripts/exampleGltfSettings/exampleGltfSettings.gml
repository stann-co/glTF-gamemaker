function exampleGltfSettings() {
	static s = {
		testRooms : [
			r01_gltfAnimations,
			r02_gltfWeights,
			r03_gltfBlending,
			//r98_stress,
		],
		currentRoom : -1,
		
		defaultShader : shGltfPSX,
		//defaultShader : shGltfSkinnedMesh,
		
		testFile : "mikuleek.gltf",
		//testFile : "testfile5.gltf",
		//testFile : "cube.gltf",
		
		cullMode : cull_noculling, // generally want cull_clockwise for backface culling
		
		drawBones : false,
	};
	return s;
}

function exampleGltfNextTestRoom() {
	var rooms = exampleGltfSettings().testRooms;
	var current = (exampleGltfSettings().currentRoom+1) mod array_length(rooms);
	exampleGltfSettings().currentRoom = current;
	room_goto(rooms[current]);
}
