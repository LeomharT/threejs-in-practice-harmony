varying vec2 vUv;

uniform float uTime;
uniform float uAspect;

void main(){
    vec2  uv       = vUv;
    vec3  color    = vec3(0.0);
    float lineWidth = 0.01;

    uv -= uTime * 0.25;
    uv *= 5.0;

    vec2 girdUV = fract(uv);

    if(girdUV.x < lineWidth) color = vec3(1.0);
    if(girdUV.y < lineWidth * uAspect) color = vec3(1.0);

    gl_FragColor = vec4(color, 1.0);
}