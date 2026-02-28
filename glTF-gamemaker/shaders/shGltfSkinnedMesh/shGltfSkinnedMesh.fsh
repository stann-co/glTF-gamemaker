varying vec2 vTexcoord;
varying vec4 vColour;
varying vec3 vNormal;

void main()
{
	vec4 col = vColour;
	col *= texture2D( gm_BaseTexture, vTexcoord);
    gl_FragColor = vec4(col.rgb, 1.);
}
