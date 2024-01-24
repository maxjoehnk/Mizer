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
    let count: i32 = texture_count;
    var rgb: vec3<f32>;
    for (var i: i32 = 0; i < count; i++) {
        let pixel = textureSample(t_diffuse[i], s_diffuse, in.tex_coords);
        let alpha_pixel = pixel.rgb * pixel.a;

        if (i == 0) {
            rgb = alpha_pixel;
            continue;
        }
        rgb = blendScreen(rgb, pixel.rgb, pixel.a);
    }

    return vec4<f32>(rgb, 1.0);
}

fn screenChannel(base: f32, blend: f32) -> f32 {
	return 1.0 - ((1.0 - base) * (1.0 - blend));
}

fn screen(base: vec3<f32>, blend: vec3<f32>) -> vec3<f32> {
	return vec3(screenChannel(base.r, blend.r), screenChannel(base.g, blend.g), screenChannel(base.b, blend.b));
}

fn blendScreen(base: vec3<f32>, blend: vec3<f32>, opacity: f32) -> vec3<f32> {
	return (screen(base, blend) * opacity + base * (1.0 - opacity));
}
