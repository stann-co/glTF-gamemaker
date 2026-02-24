/**
 * automatically set a shader and apply uniforms from an array
 * @param {Asset.GMShader} shaderID Description
 * @param {array<Struct.shaderUniform} [uniforms]=[] uniforms
 */
function setShader(shaderID, uniforms=[]) {
	shader_set(shaderID);
	for (var i = 0; i < array_length(uniforms); i++) {
		uniforms[i].go();
	}
}

/**
 * helper instance for shader_set_uniform_f
 * @param {Asset.GMShader} _shaderID Description
 * @param {String} _name uniform name
 * @param {array} [_values]=[] up to four floats (x,y,z,w in shader, missing values default to zero)
 */
function shaderUniformFloat(_shaderID, _name, _values=[]) : __shader_uniform(_shaderID, _name) constructor {
	setValues(_values);
	
	/// apply the uniforms
	static go = function() {
		shader_set_uniform_f(uref,
			values[0],
			values[1],
			values[2],
			values[3]
		);
	};
}

/**
 * helper instance for texture_set_stage. 
 * @param {asset.GMShader} _shaderID Description
 * @param {string} _name sampler name
 * @param {Pointer.Texture} _tex texture
 * @param {array<real>} [_uvs]=[0,0,1,1] UVs. uses sampler name concatenated with "UV" as uniform
 * @param {string} [_uvs_name]=_name+"UV" uv uniform name
 */
function shaderUniformSampler(_shaderID, _name, _tex, _uvs=[0,0,1,1], _uvs_name=_name+"UV") : __shader_uniform(_shaderID, _name) constructor {
	sref = shader_get_sampler_index(_shaderID, _name);
	uref = shader_get_uniform(_shaderID, _uvs_name);
	
	static __setValues = setValues; // store the base method
	
	/// set uniform values
	static setValues = function(_tex, _uvs=values) {
		__setValues(_uvs);
		tex = _tex;
		return self;
	};
	setValues(_tex, _uvs);
	
	/// apply the uniforms
	static go = function() {
		texture_set_stage(sref, tex);
		shader_set_uniform_f(uref,
			values[0],
			values[1],
			values[2],
			values[3]
		);
	};
}

/// @desc  data structure for storing shader uniforms. !!parent only!!
/// @param {Asset.GMShader} _shaderID Description
/// @param {String} _name uniform name
function __shader_uniform(_shaderID, _name) constructor {
	shader = _shaderID;
	name = _name;
	
	uref = shader_get_uniform(shader, name);
	values = array_create(4, 0);
	
	/// set uniform values
	static setValues = function(_values=[]) {
		array_copy(values, 0, _values, 0, min(4, array_length(_values)));
		return self;
	};
	
	/// apply the uniforms
	static go = function() {
	};
}