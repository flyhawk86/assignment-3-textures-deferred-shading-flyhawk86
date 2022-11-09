#version 330 core

layout(location = 0) in vec3 position;

out vec2 TexCoords;

void main(){
    gl_Position =  vec4(position,1);
    TexCoords = (position.xy+vec2(1,1))/2.0;
}
