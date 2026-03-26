#version 320 es

precision mediump float;
in vec2 v_texcoord;
layout(location = 0) out vec4 fragColor;
uniform sampler2D tex;

const float SATURATION = 1.10;
const float CONTRAST   = 1.02;
const float BRIGHTNESS = 0.98;
const vec3  COLOR_BALANCE = vec3(1.11, 0.95, 0.82);

const vec3 W = vec3(0.2126, 0.7152, 0.0722);

void main() {
    vec4 pixel = texture(tex, v_texcoord);
    vec3 c = pixel.rgb;

    float luma = dot(c, W);
    c = mix(vec3(luma), c, SATURATION);
    c = clamp((c - 0.5) * CONTRAST + 0.5, 0.0, 1.0);
    c *= BRIGHTNESS;
    c *= COLOR_BALANCE;

    fragColor = vec4(clamp(c, 0.0, 1.0), pixel.a);
}
