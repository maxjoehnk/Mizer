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
var t_diffuse: texture_2d<f32>;
@group(0) @binding(1)
var s_diffuse: sampler;

@group(1) @binding(0)
var<uniform> in_hsv: vec3<f32>;

@fragment
fn fs_main(in: VertexOutput) -> @location(0) vec4<f32> {
    let pixel = textureSample(t_diffuse, s_diffuse, in.tex_coords);

    var hsv: vec3<f32> = rgb_to_hsv(pixel.rgb);
    hsv.x *= in_hsv.x;
    hsv.y *= in_hsv.y;
    hsv.z += in_hsv.z;

    let rgb = hsv_to_rgb(hsv);

    return vec4<f32>(
        rgb.r,
        rgb.g,
        rgb.b,
        pixel.a
    );
}

fn rgb_to_hsv(rgb: vec3<f32>) -> vec3<f32> {
    let M = max(rgb.r, max(rgb.g, rgb.b));
    let m = min(rgb.r, min(rgb.g, rgb.b));
    let C = M - m;

    var h: f32;
    if C == 0.0 {
        h = 0.0;
    } else if M == rgb.r {
        h = ((rgb.g - rgb.b) / C) % 6.0;
    } else if M == rgb.g {
        h = ((rgb.b - rgb.r) / C) + 2.0;
    } else {
        h = ((rgb.r - rgb.g) / C) + 4.0;
    }

    var s: f32;
    if M == 0.0 {
        s = 0.0;
    } else {
        s = C / M;
    }

    let v = M;

    return vec3<f32>(h, s, v);
}

fn hsv_to_rgb(hsv: vec3<f32>) -> vec3<f32> {
    let C = hsv.z * hsv.y;
    let h = hsv.x / 60.0;
    let X = C * (1.0 - abs((h % 2.0) - 1.0));
    var rgb1: vec3<f32>;
    if 0.0 <= h && h < 1.0 {
        rgb1 = vec3<f32>(C, X, 0.0);
    }else if (1.0 <= h && h < 2.0) {
        rgb1 = vec3<f32>(X, C, 0.0);
    }else if (2.0 <= h && h < 3.0) {
        rgb1 = vec3<f32>(0.0, C, X);
    }else if (3.0 <= h && h < 4.0) {
        rgb1 = vec3<f32>(0.0, X, C);
    }else if (4.0 <= h && h < 5.0) {
        rgb1 = vec3<f32>(X, 0.0, C);
    }else if (5.0 <= h && h < 6.0) {
        rgb1 = vec3<f32>(C, 0.0, X);
    }

    let m = hsv.z - C;

    return vec3<f32>(
        rgb1.r + m,
        rgb1.g + m,
        rgb1.b + m
    );
}
