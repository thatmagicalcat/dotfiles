float blend = 0.9;

float random(vec2 p) {
    return fract(sin(dot(p, vec2(1.0,2.0))) * 3.14);
}

float noise(vec2 p) {
    vec2 i = floor(p);
    vec2 f = fract(p);
    
    float a = random(i);
    float b = random(i + vec2(1.0, 0.0));
    float c = random(i + vec2(0.0, 1.0));
    float d = random(i + vec2(1.0, 1.0));

    vec2 smooth_f = f * f * (3.0 - 2.0 * f);
    return mix(mix(a, b, smooth_f.x), mix(c, d, smooth_f.x), smooth_f.y);
}

float sdCircle(in vec2 p, in float r)  {
    return length(p) - r;
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    vec2 uv = (2.0 * fragCoord - iResolution.xy) / iResolution.y;
    float n = noise(uv * 5.0 + iTime * 1.5);
    vec2 uvDistorted = uv + vec2(n * 0.5, n * 0.5);

    float goop = sdCircle(uvDistorted, 1.5);
    goop = sin(goop * 4.0 + iTime * 0.5);

    vec3 original_color = texture(iChannel0, fragCoord / iResolution.xy).rgb;

    vec3 col = vec3(0.02 / abs(goop + 0.5) * (3.33 - n));
    fragColor = vec4(mix(col, original_color, blend), 1.0);
}
