#version 330 core

in vec2 TexCoords;

out vec4 outColor;

uniform sampler2D renderedTexture;
uniform sampler2D gNormal;
uniform sampler2D gPosition;

uniform vec3 lightPos;
uniform vec3 lightParams;
uniform vec3 camPos;

void main(){
//    vec3 color = texture( renderedTexture, TexCoords).xyz;
//    outColor = vec4(color, 1.0);



    vec3 col = texture(renderedTexture, TexCoords).rgb;
    vec3 triangleColorModified = col;
    vec3 normal = texture(gNormal, TexCoords).rgb;
    vec3 pos = texture(gPosition, TexCoords).rgb;

    vec3 lightDir = normalize(lightPos - pos);
    col = clamp( triangleColorModified * lightParams.x +
    triangleColorModified * max(0.0, dot(normal, lightDir)) +
    vec3(1.0) * pow(max(0.0, dot( normalize(camPos - pos), normalize( reflect(-lightDir, normal)))), lightParams.y),
                 0.0, 1.0);

    outColor = vec4(col, 1.0);



//    // from fragment 1
//    vec3 col = texture(tex, Texcoord).xyz;
//    vec3 triangleColorModified = col;
//    vec3 normal = normalize(n);
//    vec3 lightDir = normalize(lightPos - pos);
//    col = clamp( triangleColorModified * lightParams.x +
//    triangleColorModified * max(0.0, dot(normal, lightDir)) +
//    vec3(1.0) * pow(max(0.0, dot( normalize(camPos - pos), normalize( reflect(-lightDir, normal)))), lightParams.y),
//                 0.0, 1.0);
//    outColor = vec4(col, 1.0);
}