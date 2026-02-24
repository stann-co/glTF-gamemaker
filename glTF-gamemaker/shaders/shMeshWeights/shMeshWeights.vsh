attribute vec3 in_Position;                  // (x,y,z)
attribute vec3 in_Normal;                  // (x,y,z)
attribute vec2 in_TextureCoord;              // (u,v)
attribute vec4 in_Indices;
attribute vec4 in_Weights;
attribute vec4 in_Colour;                    // (r,g,b,a)

varying vec2 vTexcoord;
varying vec4 vColour;
varying vec3 vNormal;
varying float vWeight;

uniform mat4 uBones[24];
uniform float uBoneID;

void main(void) {
	mat4 skinMatrix =
		in_Weights.x * uBones[int(in_Indices.x)] +
		in_Weights.y * uBones[int(in_Indices.y)] +
		in_Weights.z * uBones[int(in_Indices.z)] +
		in_Weights.w * uBones[int(in_Indices.w)];
		
	vec4 pos = vec4(in_Position, 1.);
	pos = skinMatrix * pos;
	
	pos = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * pos;
	
	gl_Position = pos;
	
	vWeight = 0.;
	for (int i = 0; i < 4; i++) {
		vWeight += in_Weights[i] * step(abs(in_Indices[i]-uBoneID), .25);
	}
	
	vTexcoord = in_TextureCoord;
	vColour = in_Colour;
	vNormal = in_Normal;
}
