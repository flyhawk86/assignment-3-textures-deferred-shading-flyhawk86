#version 150 core

out vec4 outColor;

in vec3 n;
in vec3 color;
in vec3 pos;

uniform vec3 triangleColor;
uniform vec3 lightPos;
uniform vec3 lightParams;
uniform vec3 camPos;

in vec2 Texcoord;//
uniform sampler2D tex; //

void main()
{
//    vec3 col = color;
//    vec3 normal = normalize(n);
//    vec3 lightDir = normalize(lightPos - pos);
//    col = clamp( triangleColor * lightParams.x +
//        triangleColor * max(0.0, dot(normal, lightDir)) +
//        vec3(1.0) * pow(max(0.0, dot( normalize(camPos - pos), normalize( reflect(-lightDir, normal)))), lightParams.y),
//        0.0, 1.0);
    
//    outColor = vec4(col, 1.0);
//    outColor = texture(tex, Texcoord) * vec4(vec3(1.0, 1.0, 1.0), 1.0); //


    vec3 col = texture(tex, Texcoord).xyz;
    vec3 triangleColorModified = col;
    vec3 normal = normalize(n);
    vec3 lightDir = normalize(lightPos - pos);
    col = clamp( triangleColorModified * lightParams.x +
    triangleColorModified * max(0.0, dot(normal, lightDir)) +
    vec3(1.0) * pow(max(0.0, dot( normalize(camPos - pos), normalize( reflect(-lightDir, normal)))), lightParams.y),
                 0.0, 1.0);
    outColor = vec4(col, 1.0);
}

