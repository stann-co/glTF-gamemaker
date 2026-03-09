//vertex_format_add_position_3d();
//vertex_format_add_normal();
//vertex_format_add_texcoord();
//vertex_format_add_custom(vertex_type_ubyte4, vertex_usage_texcoord); // INDICES
//vertex_format_add_custom(vertex_type_float4, vertex_usage_texcoord); // WEIGHTS
//vertex_format_add_color();


attribute vec3 in_Position;                  // (x,y,z)
attribute vec3 in_Normal;                  // (x,y,z)
attribute vec2 in_TextureCoord;              // (u,v)
attribute vec4 in_Indices;
attribute vec4 in_Weights;
attribute vec4 in_Colour;                    // (r,g,b,a)

varying vec2 vTexcoord;
varying vec4 vColour;
varying vec3 vNormal;
varying float vAffine;

uniform mat4 uBones[24]; //increase this if needing more bones

const vec3 LIGHT = vec3(-80., -160., -40.);

#define VERTEX_SNAP(grid,axes) pos.axes = floor(pos.axes / grid) * grid

#define AFFINE_TEXMAP pos.z

void main()
{
	mat4 skinMatrix =
		in_Weights.x * uBones[int(in_Indices.x)] +
		in_Weights.y * uBones[int(in_Indices.y)] +
		in_Weights.z * uBones[int(in_Indices.z)] +
		in_Weights.w * uBones[int(in_Indices.w)];
		
	vec4 pos = vec4(in_Position, 1.);
	pos = skinMatrix * pos;
	
	vec3 posLit = (gm_Matrices[MATRIX_WORLD] * pos).xyz;
	
	pos = gm_Matrices[MATRIX_WORLD_VIEW] * pos;
	
	// vertex jitter
	#ifdef VERTEX_SNAP
		VERTEX_SNAP(2., xy);
	#endif
	
	pos = gm_Matrices[MATRIX_PROJECTION] * pos;
	
	gl_Position = pos;
	
	vec4 N = (skinMatrix * vec4(in_Normal, 0.));
	N = gm_Matrices[MATRIX_WORLD] * N;
	
	#ifdef AFFINE_TEXMAP
		vAffine = pos.z;
	#else
		vAffine = 1.;
	#endif
	
	vNormal = normalize(N.xyz);
	vColour = in_Colour;
    vTexcoord = in_TextureCoord * vAffine;
	
	// test light
	vec3 light = 2. * normalize(posLit - LIGHT);
	float NdotL = abs(dot(light, vNormal));
	
	vColour = vec4(vec3(NdotL), 1.);
}
