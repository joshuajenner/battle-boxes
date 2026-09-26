shader_type canvas_item;

uniform vec3 colour;
uniform float alpha;

void fragment() {
	vec4 texture_color = texture(TEXTURE, UV);
	COLOR = vec4(mix(texture_color.rgb, colour, alpha), texture_color.a);
}
