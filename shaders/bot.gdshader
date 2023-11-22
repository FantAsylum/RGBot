shader_type canvas_item;

uniform vec4 bot_color: source_color = vec4(1., 0., 0., 1.);

const vec3 silver = vec3(192./255.);
const vec3 grey = vec3(128./255.);

float circle(vec2 uv, float r) {
	return 1. - step(r, length(uv));
}

float ellipse(vec2 uv, float a, float b) {
	return 1. - step(1., uv.x / a + uv.y / b);
}

// TODO: add "mouth"
// TODO: add engines
// TODO: add flames
// TODO: add glowing
// TODO: gradient?

void fragment() {
	vec2 uv = UV;
	bool stub = false;
	
	COLOR = vec4(0., 0., 0., 1.);
	if (stub) {
		uv -= 0.125;
		uv *= 2.;
		vec4 color = vec4(0.);
		color += circle(uv, 0.25) * bot_color;
		COLOR = color;
	} else {
		uv *= 4.;
		uv -= 0.5;
		
		float mask = 0.;
		vec2 uv2 = uv;
		uv2.x -= 0.25;
		uv2.y += 0.125;
		mask = circle(uv2, 0.125);
		COLOR += mask * bot_color;
		if (mask == 0.) {
			mask = circle(uv, 0.5);
			COLOR = mask * vec4(silver, 1.);
		}
	}
}
