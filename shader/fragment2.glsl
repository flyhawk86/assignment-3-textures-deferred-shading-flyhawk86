#version 330 core

in vec2 TexCoords;

out vec4 outColor;

uniform sampler2D renderedTexture;
uniform sampler2D gNormal;
uniform sampler2D gPosition;
uniform sampler2D gDepth;

uniform vec3 lightPos;
uniform vec3 lightParams;
uniform vec3 camPos;

void main(){
    vec3 col = texture(renderedTexture, TexCoords).rgb;
    vec3 triangleColorModified = col;
    vec3 normal = texture(gNormal, TexCoords).rgb;
    vec3 pos = texture(gPosition, TexCoords).rgb;

    vec3 lightDir = normalize(lightPos - pos);
    col = clamp( triangleColorModified * lightParams.x +
    triangleColorModified * max(0.0, dot(normal, lightDir)) +
    vec3(1.0) * pow(max(0.0, dot( normalize(camPos - pos), normalize( reflect(-lightDir, normal)))), lightParams.y),
                 0.0, 1.0);

//    outColor = vec4(col, 1.0);
//
    float currDepth = texture(gDepth, TexCoords).r;
    vec2 leftTex = clamp(TexCoords + vec2(-1/1600.0, 0), 0.0, 1.0); float leftDepth = texture(gDepth, leftTex).r;
    vec2 rightTex = clamp(TexCoords + vec2(1/1600.0, 0), 0.0, 1.0); float rightDepth = texture(gDepth, rightTex).r;
    vec2 downTex = clamp(TexCoords + vec2(0, -1/1200.0), 0.0, 1.0); float downDepth = texture(gDepth, downTex).r;
    vec2 upTex = clamp(TexCoords + vec2(0, 1/1200.0), 0.0, 1.0); float upDepth = texture(gDepth, upTex).r;

    if(abs(currDepth-leftDepth) > 0.4 ||
        abs(currDepth-rightDepth) > 0.4 ||
        abs(currDepth-upDepth) > 0.4 ||
        abs(currDepth-downDepth) > 0.04
    ){
        outColor = vec4(0.0, 0.0, 0.0, 1.0);
    }else{
        outColor = vec4(col, 1.0);
    }
}