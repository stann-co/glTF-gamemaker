function debugPrint(str, args=[]) {
	if (GLTF_DEBUG) show_debug_message(string(current_time)+": "+string_ext(str, args));
}

function hudDisplayText(str, time=180) {
	with (World) {
		debugText = str;
		debugTextTimer = time;
	}
}
