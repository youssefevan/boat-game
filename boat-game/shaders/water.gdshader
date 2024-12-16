shader_type spatial;

uniform float height_scale = 1.0;
uniform float wave_speed = 1.0;
uniform float wave_scale = 0.2;
uniform float wave_time = 0.0;

varying float theta;

uniform sampler2D normalmap;
varying vec2 tex_pos;

void vertex() {
	theta += wave_speed * wave_time;
	
	tex_pos = VERTEX.xz/2.0 + 0.5;
	
	// apply height map to vertices
	float height = cos(VERTEX.x * wave_scale + theta) * sin(VERTEX.z * wave_scale + theta);
	VERTEX.y += height * height_scale;
}

void fragment() {
	NORMAL_MAP = texture(normalmap, tex_pos).xyz;
	ROUGHNESS = 0.5;
	ALBEDO = vec3(0.0, 0.15, 0.3);
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
