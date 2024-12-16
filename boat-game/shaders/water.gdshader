shader_type spatial;
render_mode specular_toon;

uniform sampler2D noise;
uniform sampler2D normalmap;

uniform float height_scale = 1.0;
uniform float wave_speed = 1.0;
uniform float wave_scale = 0.2;
uniform float wave_time = 0.0;

varying vec2 tex_position;
varying float theta;

void vertex() {
	theta += wave_speed * wave_time;
	
	// apply height map to vertices
	tex_position = VERTEX.xz/2.0 + 0.5 * TIME;
	float height = cos(VERTEX.x * wave_scale + theta) * sin(VERTEX.z * wave_scale + theta);
	VERTEX.y += height * height_scale;
}

void fragment() {
	NORMAL_MAP = texture(normalmap, tex_position).xyz;
	ROUGHNESS = 0.5;
	ALBEDO = vec3(0, 0.5, 0.8);
	RIM = 0.2;
	ALPHA = 0.5;
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
