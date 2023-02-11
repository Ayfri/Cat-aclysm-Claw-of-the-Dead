shader_type canvas_item;

uniform sampler2D mask;
uniform vec4 color : source_color;

void fragment() {
	vec4 mask_color = texture(mask, UV).rgba;
	vec4 sprite_color = texture(TEXTURE, UV).rgba;
	
	if (sprite_color.a != 0.0) {
		sprite_color.a = mask_color.a;
		sprite_color.rgb = color.rgb;
	}
	
	COLOR = sprite_color;
}