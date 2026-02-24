event_inherited();

World.exampleText = "animation blend tester";
World.debugTextDefault = "1-9 toggle animation";

animations = 0;
animationOn = [ false ];

if (skinned) {
	animations = variable_struct_names_count(testSkin.skin.animLength);
	animationOn = array_create(animations, false);
}
