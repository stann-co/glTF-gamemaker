gltfLoad("Arrows.gltf");

skin = new skinnedMesh("Arrows");
skin.setAnimation("Move");
skin.animate(0);

shift = false;

x = 512;
y = 0;

t = 0;
tMin = 0;
tMax = skin.getAnimationLength();

draw = function() {
	skin.draw(gltfSettings().defaultShader);
};
