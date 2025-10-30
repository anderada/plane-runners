shader_type canvas_item;

uniform sampler2D noise_image : repeat_enable;
uniform float speed = 1;
uniform vec4 flame_middle : source_color;
uniform vec4 flame_edge : source_color;
uniform float threshold = 0.3;
uniform float intensity = 2;
uniform float airyness = 0.1;

void fragment(){
	vec2 uvr = vec2(UV.x ,0.0 + TIME * speed / 4.0);
	vec2 uvg = vec2(UV.x ,0.0 + TIME * speed);
	vec2 uvb = vec2(UV.x ,0.0 + TIME * speed / 1.5);
	
	float noise_r = texture(noise_image,uvr).r;
	float noise_g = texture(noise_image,uvg).g;
	float noise_b = texture(noise_image,uvb).b;
	
	
	float new_alpha = noise_r * noise_g * noise_b * intensity - airyness;
	new_alpha = new_alpha * (-5.0 * ((UV.x-0.5) * (UV.x-0.5)) + 1.0);
	new_alpha = clamp(new_alpha,0,1);
	new_alpha = new_alpha * (UV.y * 2.0 );

	COLOR = flame_edge;
	COLOR.a = new_alpha;
}
