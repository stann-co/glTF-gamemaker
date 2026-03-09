function meshGrid(w, h, col=c_white, alpha=1) {
	// floor grid mdl
	var mesh = vertex_create_buffer();
	vertex_begin(mesh, __gltfVertexFormatWire());
	var n = 10;
	for (var i = 0; i < w+1; i++) {
		vertex_position_3d(mesh, i, 0, 0);
		vertex_color(mesh, col, alpha);
		vertex_position_3d(mesh, i, -h, 0);
		vertex_color(mesh, col, alpha);
	}
	for (var i = 0; i < h+1; i++) {
		vertex_position_3d(mesh, 0, -i, 0);
		vertex_color(mesh, col, alpha);
		vertex_position_3d(mesh, w, -i, 0);
		vertex_color(mesh, col, alpha);
	}
	vertex_end(mesh);
	vertex_freeze(mesh);
	
	return mesh;
}
