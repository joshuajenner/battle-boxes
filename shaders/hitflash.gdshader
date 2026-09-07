shader_type canvas_item;

uniform float value;

void fragment() {
	vec4 texture_color = texture(TEXTURE, UV);
	COLOR = vec4(mix(texture_color.rgb, vec3(1,0,0), value), texture_color.a);
}
