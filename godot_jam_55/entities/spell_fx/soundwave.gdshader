shader_type canvas_item;

uniform vec4 wave_color : source_color = vec4(1.0);
uniform float wave_speed;
uniform float wave_thickness;

const float pixel_size = 32.0;

float circle(vec2 position, float radius)
{
	return 1.0 - step(radius, length(position - vec2(0.5)));
}

void fragment() {
	vec2 grid_uv = round(UV * float(pixel_size)) / float(pixel_size);
	
	float radius =  (1.0 + tan(TIME * wave_speed)) / 2.0;
	float outer_circle = circle(grid_uv, radius);
	float mask = circle(grid_uv, radius - wave_thickness);
	
	vec4 ring = wave_color * vec4(outer_circle) - mask;
	
	COLOR = mix(texture(TEXTURE, UV), ring, COLOR.a);
}
