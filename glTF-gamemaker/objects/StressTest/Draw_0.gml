for (var i = 0; i < meshCount; i++) {
	var pos = positions[i];
	drawTransformed(pos.x, pos.y, pos.z, 0, scale, function() {
		testSkin.draw(exampleGltfSettings().defaultShader);
	});
}
