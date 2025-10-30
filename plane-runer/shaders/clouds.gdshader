shader_type spatial;

render_mode unshaded;

uniform sampler2D noise_image : repeat_enable;
uniform float speed = 1;
uniform vec3 color : source_color;
uniform float repeat = 5;

void fragment() {
	vec2 uvr = vec2((UV.x * repeat) ,(UV.y * repeat) - TIME * speed / 4.0);
	vec2 uvg = vec2((UV.x * repeat) ,(UV.y * repeat) - TIME * speed);
	vec2 uvb = vec2((UV.x * repeat) ,(UV.y * repeat) + TIME * speed / 1.5);
	
	float noise_r = texture(noise_image,uvr).r;
	float noise_g = texture(noise_image,uvg).g;
	float noise_b = texture(noise_image,uvb).b;
	
	
	float new_alpha = noise_r * noise_g * noise_b * 10.0;
	new_alpha = 10.0 / (1.0 + pow(2.0, 1.0 * new_alpha)) * 1.0 -2.0;
	new_alpha = clamp(new_alpha,0,1);
	ALBEDO = color * new_alpha + 0.7;
}

void vertex(){
	vec2 uvr = vec2((UV.x * repeat) ,(UV.y * repeat) - TIME * speed / 4.0);
	vec2 uvg = vec2((UV.x * repeat) ,(UV.y * repeat) - TIME * speed);
	vec2 uvb = vec2((UV.x * repeat) ,(UV.y * repeat) + TIME * speed / 1.5);
	
	float noise_r = texture(noise_image,uvr).r;
	float noise_g = texture(noise_image,uvg).g;
	float noise_b = texture(noise_image,uvb).b;
	
	
	float new_alpha = noise_r * noise_g * noise_b * 10.0;
	new_alpha = 10.0 / (1.0 + pow(2.0, 1.0 * new_alpha)) * 1.0 -2.0;
	new_alpha = clamp(new_alpha,0,1);
	VERTEX.y += new_alpha / 40.0;
}

