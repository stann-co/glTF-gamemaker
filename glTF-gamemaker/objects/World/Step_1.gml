/// @desc debug keyboard input

if (GLTF_DEBUG) {
	if (keyboard_check_pressed(vk_escape)) {
		game_end();
		exit;
	}
	
	if (keyboard_check_pressed(vk_f1)) {
		showDebug = !showDebug;
		show_debug_overlay(showDebug);
	}
	
	if (keyboard_check_pressed(vk_delete)) {
		clearLoadedTextures(); // this will crash YYC
	}
	
	if (--debugTextTimer <= 0) {
		debugText = debugTextDefault;
	}
	
	if (keyboard_check_pressed(vk_space)) {
		gltfNextTestRoom();
		exit;
	}
}
else {
	debugText = "";
}



