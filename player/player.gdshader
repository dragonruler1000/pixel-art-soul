shader_type canvas_item;
uniform bool is_invincible = false;

//const vec4 white = vec4(1.0, 1.0, 1.0, 1.0);

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	// Called for every pixel the material is visible on.
	vec4 base_color = texture(TEXTURE, UV) * COLOR;
	if (is_invincible){
		// Flashing effect using TIME: on/off every 0.1 seconds
		float flash = step(0.5, fract(TIME * 2.0)); // Adjust the 10.0 to change speed
		base_color.rgb = mix(base_color.rgb, vec3(1.0), flash); // mix original with white
		//COLOR = white;
	}
	COLOR = base_color;
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
