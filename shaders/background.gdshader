shader_type canvas_item;

uniform float position = 0.;
uniform float cameraZ = -1.;
uniform float farZ = 1.;
uniform float farY = 0.;
uniform float nearZ = -1.;
uniform float distanceBetweenLines = 0.25;
uniform int linesCount = 20;

const vec4 blackColor = vec4(vec3(0.), 1.);
const vec4 whiteColor = vec4(1.);

float line(vec2 uv, vec2 a, vec2 b, float blur) {
	// if (uv.x < min(a.x, b.x) - blur || uv.x > max(a.x, b.x) + blur)
	//	return 0.;
	if (uv.y < min(a.y, b.y) - blur || uv.y > max(a.y, b.y) + blur)
		return 0.;
	float mask = smoothstep(blur, 0., abs((uv.x - a.x) - (uv.y - a.y) * (b.x - a.x) / (b.y - a.y)));
	mask += smoothstep(blur, 0., abs((uv.y - a.y) - (uv.x - a.x) * (b.y - a.y) / (b.x - a.x)));
	return mask;
}

vec2 projection(vec3 camera, vec3 p) {
    float x = (-camera.z) / (p.z - camera.z) * (p.x - camera.x) + camera.x;
    float y = (-camera.z) / (p.z - camera.z) * (p.y - camera.y) + camera.y;
    return vec2(x, y);
}

void fragment() {
	vec3 camera = vec3(0., -0.75, cameraZ);
	vec2 uv = UV * 8. - 1.;
	
	COLOR = blackColor;
	float blur = 0.02;
	float x = -mod(position / 1000., distanceBetweenLines * float(linesCount));
	x -= 2. * (float(linesCount) / 2.) * distanceBetweenLines;
	for (int i = 0; i < linesCount * 4; i++) {
		vec2 cc = projection(camera, vec3(x, farY, nearZ));
		vec2 cp = projection(camera, vec3(x, farY, farZ));
		x += distanceBetweenLines;
		COLOR += whiteColor * line(uv, cc, cp, blur);
	}
	
	// horizontal
	for (float z = nearZ; z <= farZ + blur; z += distanceBetweenLines) {
		vec2 cc = projection(camera, vec3(-1., farY, z));
		vec2 cp = projection(camera, vec3(1., farY, z));
		COLOR += whiteColor * line(uv, cc, cp, blur);
	}
	
}
