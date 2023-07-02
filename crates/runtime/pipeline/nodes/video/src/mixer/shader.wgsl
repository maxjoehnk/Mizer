// Vertex shader

struct VertexInput {
    @location(0) position: vec3<f32>,
    @location(1) tex_coords: vec2<f32>,
};

struct VertexOutput {
    @builtin(position) clip_position: vec4<f32>,
    @location(0) tex_coords: vec2<f32>,
};

@vertex
fn vs_main(
    model: VertexInput,
) -> VertexOutput {
    var out: VertexOutput;
    out.tex_coords = model.tex_coords;
    out.clip_position = vec4<f32>(model.position, 1.0);
    return out;
}

// Fragment shader

@group(0) @binding(0)
var t_diffuse: binding_array<texture_2d<f32>>;
@group(0) @binding(1)
var s_diffuse: sampler;
@group(1) @binding(0)
var<uniform> texture_count: i32;

@fragment
fn fs_main(in: VertexOutput) -> @location(0) vec4<f32> {
//    let count: i32 = i32(arrayLength(t_diffuse));
    let count: i32 = texture_count;
    var rgb: vec3<f32>;
    for (var i: i32 = 0; i < count; i++) {
        let pixel = textureSample(t_diffuse[i], s_diffuse, in.tex_coords);

        rgb += pixel.rgb * pixel.a;
    }

    return vec4<f32>(rgb, 1.0);
}
