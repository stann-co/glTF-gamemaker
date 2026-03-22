gltfLoad("Arrows.gltf");

skin = new gltfSkinnedMesh("Arrows");
skin.setAnimation("Move");
skin.animate(0);

shift = false;

x = 512;
y = 0;

t = 0;
tMin = 0;
tMax = skin.getAnimationLength();

skin.position.x = x;
skin.position.y = y;
skin.setScale(16);

draw = function() {
	skin.draw(exampleGltfSettings().defaultShader);
};
