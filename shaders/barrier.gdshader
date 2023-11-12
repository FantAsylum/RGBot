shader_type canvas_item;

uniform vec4 firstColor: source_color;
uniform vec4 secondColor: source_color;
uniform vec4 thirdColor: source_color;

void fragment() {
	vec2 uv = UV;
	float ymax = .25;
	float ymin = 0.;
	
	if (uv.y < (ymax - ymin) / 3.)
		COLOR = firstColor;
	else if (uv.y < (ymax - ymin) / 3. * 2.)
		COLOR = secondColor;
	else 
		COLOR = thirdColor;
}
