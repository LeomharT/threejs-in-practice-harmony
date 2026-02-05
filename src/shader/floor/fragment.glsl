precision mediump float;

varying vec2 vUv;

uniform float uTime;
uniform float uAspect;
uniform float uFrequency;
uniform float uLineWidth;

void main(){
    vec2  uv        = vUv;
    vec3  color     = vec3(0.02);
    float lineWidth = uLineWidth;
    float x         = uv.x;

    float wave  = sin(x * uFrequency);
          wave *= 0.5;
          wave  = (wave + 1.0) / 2.0;

    float dydx      = 0.5 * cos(x * uFrequency) * uFrequency;
    float thickness = lineWidth * sqrt(1.0 + pow(dydx, 2.0));
    float dist      = abs(uv.y - wave) / sqrt(1.0 + dydx * dydx);
   
    bool c = abs(uv.y - wave) < thickness * 0.5;
    bool c_ = uv.y > wave && uv.y < wave + lineWidth * 5.0;

    if(c_ || c) {
        color = vec3(1.0, 0.725, 0.0125);
    }

    gl_FragColor = vec4(color, 1.0);

    #include <tonemapping_fragment>
    #include <colorspace_fragment>
}