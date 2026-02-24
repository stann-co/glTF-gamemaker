varying vec2 vTexcoord;
varying vec4 vColour;
varying vec3 vNormal;
varying vec2 vScreen;
varying float vAffine;

uniform float uTime;

#define DITHER_LEVELS (15.) // odd number, ideally 2^n-1

void main()
{
	vec4 col = vColour;
	
	#ifdef DITHER_LEVELS
		// this is assuming light source is white
		float shade = (col.r + col.g + col.b) * 0.333333333333333;
		shade = ceil(shade * DITHER_LEVELS);
		
		// if shade is odd, each pixel is coloured one shade up or down (alternating)
		float d = mod(gl_FragCoord.x + gl_FragCoord.y, 2.);
		d = 2. * (d-.5);
		shade += d * mod(shade + 1., 2.);
		
		// make shade 0-1 again
		shade /= DITHER_LEVELS;
		
		// brighten it slightly because my test light sucks
		shade += .25;
		col.rgb = vec3(shade);
	#endif
	
	col *= texture2D(gm_BaseTexture, vTexcoord / vAffine);
	
    gl_FragColor = vec4(col.rgb, 1.);
}
