shader_type canvas_item;

uniform vec4 wave_color : source_color = vec4(1.0);
uniform int wave_count = 1;
uniform float wave_distance : hint_range(0.0, 1.0) = 0.5;
uniform float wave_speed;
uniform float wave_thickness;

const float pixel_size = 32.0;

float circle(vec2 position, float radius) {
	return 1.0 - step(radius, length(position - vec2(0.5)));
}

void fragment() {
	vec2 grid_uv = floor(UV * float(pixel_size)) / float(pixel_size);
	float radius =  mod(TIME * wave_speed, 1.5);
	float outer_circle = circle(grid_uv, radius);
	float mask = circle(grid_uv, radius - wave_thickness);
	
	vec4 rings = wave_color * vec4(outer_circle) - vec4(mask);
	
	for (int i = 1; i < wave_count; i++) {
		float inner_circle = circle(grid_uv, radius - float(i) * (wave_distance / float(wave_count)));
		float inner_mask = circle(grid_uv, radius - wave_thickness - float(i) * (wave_distance / float(wave_count)));
		rings += vec4(inner_circle) - vec4(inner_mask);
	}
	
	COLOR = mix(texture(TEXTURE, UV), rings, COLOR.a);
}
