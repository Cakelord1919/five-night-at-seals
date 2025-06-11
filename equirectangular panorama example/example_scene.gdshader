shader_type spatial;

uniform sampler2D albedo_texture : source_color;
uniform vec4 albedo_color : source_color = vec4(1.0);
uniform float cut_plane = 0.0; // 0 = Y轴水平面
varying vec3 local_pos;

void vertex() {
    local_pos = VERTEX;  // 直接把模型本地坐标保存下来
}

void fragment() {
    if (local_pos.x < cut_plane) {
        discard;
    }

    vec4 tex_color = texture(albedo_texture, UV);
    ALBEDO = tex_color.rgb * albedo_color.rgb;
    ALPHA = tex_color.a * albedo_color.a;
}