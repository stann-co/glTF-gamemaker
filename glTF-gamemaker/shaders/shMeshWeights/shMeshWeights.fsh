varying vec2 vTexcoord;
varying vec4 vColour;
varying vec3 vNormal;
varying float vWeight;

void main()
{
	vec3 col = vec3(0.);
	col.r = vWeight;
	col.b = 1. - vWeight;
	gl_FragColor = vec4(col, 1.);
}
