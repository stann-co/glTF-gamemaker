if (instance_number(World) > 1) {
	instance_destroy();
	exit;
}

gpu_set_cullmode(gltfSettings().cullMode);
gpu_set_zwriteenable(true);
gpu_set_ztestenable(true);

gpu_set_texrepeat(true);


depth = -100;
instance_create_depth(0, 0, 99, Camera);

sw = 640;
sh = 480;

lastDigit = -1;

resizeScreen(sw, sh);

video = false; // this is for when i did that bad apple meme
v = [-1];

// what text displays after custom display times out
debugTextDefault = "";
debugText = debugTextDefault;
debugTextTimer = 0;

// name of example room
exampleText = "";

showDebug = false; // F1 toggle gm debug overlay

gltfNextTestRoom();
