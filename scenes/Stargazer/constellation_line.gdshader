shader_type canvas_item;

uniform sampler2D NOISE_PATTERN1 : repeat_enable;
uniform sampler2D NOISE_PATTERN2 : repeat_enable;
uniform vec2 scroll1 = vec2(1.0, 0.4);
uniform vec2 scroll2 = vec2(0.2, 1.4);
uniform float speed : hint_range(0, 1) = 0.9;
uniform float x_stretch = 1.0;
uniform float y_stretch = 0.1;

uniform float laser_size : hint_range(0, 1) = 0.5;
uniform float wobbliness : hint_range(0, 1) = 0.1;

uniform vec4 color1 : source_color;
uniform vec4 color2 : source_color;
uniform float color_mix : hint_range(0, 10) = 1;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec2 stretched_UV = UV;
	stretched_UV.x *= x_stretch;
	stretched_UV.y *= y_stretch;

	float intensity1 = textureLod(NOISE_PATTERN1, stretched_UV + TIME * scroll1 * speed, 0.0).r;
	float intensity2 = textureLod(NOISE_PATTERN2, stretched_UV + TIME * scroll2 * speed, 0.0).r;
	float intensity = intensity1 * intensity2;

	float centrality = (1.0 - abs(UV.y - 0.5)) * 0.5;

	if (wobbliness * intensity + (1.0 - wobbliness) * centrality > 1.0 - laser_size) {
		COLOR = mix(color1, color2, clamp(intensity * color_mix, 0.0, 1.0));
	}
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
