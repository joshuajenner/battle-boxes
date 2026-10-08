shader_type canvas_item;

uniform vec3 overlay_colour: source_color;
uniform float overlay_alpha;

uniform vec3 original_colour_1: source_color;
uniform vec3 original_colour_2: source_color;
uniform vec3 new_colour_1: source_color;
uniform vec3 new_colour_2: source_color;

void fragment() {
	vec4 texture_colour = texture(TEXTURE, UV);
	vec3 new_colour = vec3(0);
	
	if (texture_colour.rgb == original_colour_1)
	{
		new_colour = new_colour_1;
	} 
	else if (texture_colour.rgb == original_colour_2)
	{
		new_colour = new_colour_2;
	}
	else
	{
		new_colour = texture_colour.rgb;
	}
	
	COLOR = vec4(mix(new_colour, overlay_colour, overlay_alpha), texture_colour.a);
}