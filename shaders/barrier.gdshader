shader_type canvas_item;

uniform float projector_size: hint_range(0.01, 0.1, 0.01);
uniform vec4 firstColor: source_color;
uniform vec4 secondColor: source_color;
uniform vec4 thirdColor: source_color;

void fragment() {
	vec2 uv = UV;
	float ymax = .25;
	float ymin = 0.;
	float len =  ymax - ymin - projector_size * 2.;
	
	vec4 gray = vec4(vec3(0.5), 1.);
	if (abs(ymin - uv.y) < projector_size) {
		COLOR = gray;
	} else if (abs(ymax - uv.y) < projector_size) {
		COLOR = gray;
	} else if (uv.y < projector_size + len / 3.)
		COLOR = firstColor;
	else if (uv.y < projector_size + len / 3. * 2.)
		COLOR = secondColor;
	else 
		COLOR = thirdColor;
}
