//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;
uniform vec3 marker_colour;
uniform vec3 player_colour;

void main()
{
    gl_FragColor = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
	if (gl_FragColor.rgb==marker_colour.rgb){ 
		gl_FragColor = vec4(player_colour.r, player_colour.g, player_colour.b, gl_FragColor.a);
	}
	//gl_FragColor = vec4(player_colour.r,player_colour.g, player_colour.n,gl_FragColor.a);		
}
