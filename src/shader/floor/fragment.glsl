varying vec2 vUv;

uniform float uTime;
uniform float uAspect;
uniform float uFrequency;
uniform float uLineWidth;

void main(){
    vec2  uv        = vUv;
    vec3  color     = vec3(0.0);
    float lineWidth = uLineWidth;

    // uv -= uTime * 0.25;
    uv.y *= 5.0;

    vec2 girdUV = fract(uv);

    float wave  = sin((girdUV.x * uFrequency) + uTime);
          wave  = wave * 0.5 + 0.5;
 
    if(girdUV.y > wave && girdUV.y < wave + lineWidth){ 
        color = vec3(1.0);
    }

    // if(girdUV.x < lineWidth) color = vec3(1.0);
    // if(girdUV.y < lineWidth * uAspect) color = vec3(1.0);

    gl_FragColor = vec4(color, 1.0);

    #include <tonemapping_fragment>
    #include <colorspace_fragment>
}