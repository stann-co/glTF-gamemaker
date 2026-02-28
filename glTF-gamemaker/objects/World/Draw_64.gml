// test draw
draw_set_color(c_white);

gltfSetIdentity();

if (GLTF_DEBUG) {
	draw_text(16, 16, debugText);

	draw_text(16, sh-32, "press space to go to next example");
	draw_text(16, sh-64, exampleText);
}

//with (Camera) {
//	
//}
