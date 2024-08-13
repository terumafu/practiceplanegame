shader_type spatial;

uniform sampler2D noise;

void fragment() {
	ALBEDO = texture(noise, UV).rgb;
}
