shader_type canvas_item;

uniform vec4 bot_color: source_color;

float circle(vec2 uv, float r) {
	return 1. - step(r, length(uv));
}

void fragment() {
	vec2 uv = UV;
	
	uv -= 0.125;
	uv *= 2.;
	vec4 color = vec4(0.);
	color += circle(uv, 0.25) * bot_color;
	COLOR = color;
}
