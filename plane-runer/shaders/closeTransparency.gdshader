shader_type spatial;

render_mode cull_back, depth_draw_always;

uniform sampler2D material : source_color;

void fragment() {
	ALBEDO = texture(material, UV).rgb;
	float depth = FRAGCOORD.z;
	depth = depth * 400.0 - 3.5;
	depth = clamp(depth, 0.0, 1.0);
	ALPHA = 1.0-depth;

}

