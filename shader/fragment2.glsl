#version 330 core

in vec2 TexCoords;

out vec4 outColor;

uniform sampler2D renderedTexture;

void main(){
    vec3 color = texture( renderedTexture, TexCoords).xyz;
    outColor = vec4(color, 1.0);
}