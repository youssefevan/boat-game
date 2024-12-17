shader_type spatial;

uniform float height_scale = 1.0;
uniform float wave_speed = 1.0;
uniform float wave_scale = 0.2;
uniform float wave_time = 0.0;

varying float theta;

uniform vec4 primary_color : source_color;
uniform sampler2D tex;

//uniform sampler2D noise;

void vertex() {
	theta += wave_speed * wave_time;

	float height = cos(VERTEX.x * wave_scale + theta) * sin(VERTEX.z * wave_scale + theta);
	VERTEX.y += height * height_scale;
}

void fragment() {
	float fresnel = sqrt(1.0 - dot(NORMAL, VIEW));

	RIM = 0.2;
	ROUGHNESS = 0.02;
	//ALBEDO = primary_color.rgb + (0.1 * fresnel);
	ALPHA = 0.5;

	vec3 albedo_tex = primary_color.rgb + texture(tex, (UV*8.0+(TIME/16.0))).rgb;
	ALBEDO = albedo_tex;
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
