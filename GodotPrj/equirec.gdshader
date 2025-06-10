shader_type canvas_item;  // 用于 2D Sprite2D 或 TextureRect

uniform sampler2D panorama_texture : source_color;
uniform float rotation : hint_range(0.0, 6.283185); // 0~2π，允许你控制水平旋转

void fragment() {
    vec2 uv = (FRAGCOORD.xy / SCREEN_PIXEL_SIZE.xy) * 2.0 - 1.0;

    float longitude = atan(uv.x, uv.y) + rotation;
    float latitude = length(uv);

    float u = (longitude / (2.0 * 3.1415926)) + 0.5;
    float v = latitude;

    vec4 color = texture(panorama_texture, vec2(u, v));
    COLOR = color;
}