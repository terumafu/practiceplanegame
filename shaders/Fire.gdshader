shader_type spatial;
render_mode unshaded;

// Variables
uniform vec4 color : source_color;
uniform float scrollSpeed : hint_range(0.0, 0.2, 0.001);
uniform float bloom : hint_range(0.0, 50.0, 0.01);
uniform bool viewMask;

// Textures
uniform sampler2D noise1; // Seamless recommended, when the ColorRamp is used, set color variable to white
uniform sampler2D noise2; // ^
uniform sampler2D maskNoise1; // Used to mask out the flames
uniform sampler2D maskNoise2; // ^
uniform sampler2D mask : source_color; // Additional îmage mask, if needed

void fragment() {
	if(viewMask) {
		// Only show mask, if viewMask is true
		float bloomAmount = 1.0 + bloom;
		float maskInfluence = pow(texture(mask, UV).r, (bloom / 30.0) + 1.0);
		ALBEDO = vec3(clamp(maskInfluence * bloomAmount, 0.0, 100.0));
		
	} else {
		// Define Albedo
		vec4 tex1 = texture(noise1, UV + scrollSpeed * TIME);
		vec4 tex2 = texture(noise2, UV - scrollSpeed * TIME);
		vec4 maskTex = texture(maskNoise1, UV + scrollSpeed * 6.524565 * TIME);
		vec4 maskTex2 = texture(maskNoise2, UV - scrollSpeed * 4.234562 * TIME);
		
		ALBEDO = (tex1.rgb * tex2.rgb) * color.rgb;
		
		// Define Alpha
		vec4 maskTex3 = texture(mask, UV);
		float fireAlpha = maskTex.r - maskTex2.r;
		float bloomAmount = 1.0 + bloom;
		float maskInfluence = pow(maskTex3.r, (bloom / 30.0) + 1.0);
		
		ALPHA = clamp(fireAlpha * maskInfluence * bloomAmount, 0.0, 100.0);
	}
}