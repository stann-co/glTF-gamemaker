/// @param {String} fname
/// @param {Struct} struct
function saveStructToFile(fname, struct, encode=false) {
	var buffer = buffer_create(1024, buffer_grow, 1);
	if (encode) {
		buffer_write(buffer, buffer_string, base64_encode(json_stringify(struct)));
	}
	else {
		buffer_write(buffer, buffer_string, json_stringify(struct));
	}
	buffer_save(buffer, fname);
	buffer_delete(buffer);
}

/// @param {String} fname
/// @return {Struct}
function loadStructFromFile(fname, decode=false) {
	if (file_exists(fname)) {
		var f = buffer_load(fname);
		var json = buffer_read(f, buffer_string);
		if (decode) json = base64_decode(json);
		buffer_delete(f);
		
		return json_parse(json);
	}
	show_error("file not found: "+fname, true);
	return { };
}

function __sprites__() {
	static spr = { };
	return spr;
}
function __textures__() {
	static tex = { };
	return tex;
}

// memory leak hell babey
// need to store indices of loaded sprites in case i need to unload everything later
function __load_texture(fname) {
	var spr = sprite_add(fname, 0, false, false, 0, 0);
	var tex = sprite_get_texture(spr, 0);
	__sprites__()[$ fname] = spr;
	__textures__()[$ fname] = tex;
	return tex;
}

function getTexture(fname) {
	return __textures__()[$ "fname"] ?? __load_texture(fname);
}

function clearLoadedTextures() {
	var sprites = __sprites__();
	var textures = __textures__();
	var names = variable_struct_get_names(sprites);
	var i = 0; repeat(array_length(names)) {
		var name = names[i++];
		var sprite = sprites[$ name];
		if (!is_undefined(sprite) && sprite_exists(sprite)) {
			sprite_delete(sprite);
		}
		debugPrint("removing texture: {0}", [ name ]);
		variable_struct_remove(sprites, name);
		variable_struct_remove(textures, name);
	}
}
