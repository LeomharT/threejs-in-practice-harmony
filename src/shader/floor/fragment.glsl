varying vec2 vUv;

uniform float uTime;

void main(){
    vec2 uv    = vUv;
    vec3 color = vec3(0.0);

    uv -= uTime * 0.25;

    uv *= 5.0;
    uv  = fract(uv);

    if(uv.x < 0.2) color = vec3(1.0);
    if(uv.y < 0.2) color = vec3(1.0);

    gl_FragColor = vec4(color, 1.0);
}