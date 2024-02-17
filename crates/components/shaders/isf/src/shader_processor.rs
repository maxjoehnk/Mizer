const FRAG_NORM_COORD_STR: &str = "layout(location = 0) in vec2 isf_FragNormCoord;\n\n";

const FRAGCOLOR_OUT_DECL_STR: &str = "layout(location = 0) out vec4 FragColor;\n";

const ISF_DATA_BINDING: &str = "
layout(set = 0, binding = 0) uniform IsfData {
    int PASSINDEX;
    vec2 RENDERSIZE;
    float TIME;
    float TIMEDELTA;
    vec4 DATE;
    int FRAMEINDEX;
};\n";

const ISF_FRAGMENT_FUNCTIONS: &str = "
// ISF provided short-hand for retrieving image size.
ivec2 IMG_SIZE(texture2D img) {
    return textureSize(sampler2D(img, img_sampler), 0);
}

// ISF provided short-hand for retrieving image color.
vec4 IMG_NORM_PIXEL(texture2D img, vec2 norm_px_coord) {
    return texture(sampler2D(img, img_sampler), norm_px_coord);
}

// ISF provided short-hand for retrieving image color.
vec4 IMG_PIXEL(texture2D img, vec2 px_coord) {
    ivec2 s = IMG_SIZE(img);
    vec2 norm_px_coord = vec2(px_coord.x / float(s.x), px_coord.y / float(s.y));
    return IMG_NORM_PIXEL(img, px_coord);
}

// ISF provided short-hand for retrieving image color.
vec4 IMG_THIS_NORM_PIXEL(texture2D img) {
    return IMG_NORM_PIXEL(img, isf_FragNormCoord);
}

// ISF provided short-hand for retrieving image color.
vec4 IMG_THIS_PIXEL(texture2D img) {
    return IMG_THIS_NORM_PIXEL(img);
}\n";

pub fn process_vertex_shader(shader: String, isf: &isf::Isf) -> String {
    [ISF_DATA_BINDING, &shader].concat()
}

pub fn process_fragment_shader(shader: &str, isf: &isf::Isf) -> String {
    let isf_data_input_binding = get_isf_data_input_binding(isf).unwrap_or_default();
    let isf_textures = get_isf_textures(isf);

    [
        FRAG_NORM_COORD_STR,
        ISF_DATA_BINDING,
        &isf_data_input_binding,
        &isf_textures,
        ISF_FRAGMENT_FUNCTIONS,
        &shader,
    ]
    .concat()
}

// let isf_string = glsl_string_from_isf(&isf);
// let fragment_shader = prefix_isf_glsl_str(&isf_string, isf_str);

// Create the `IsfDataInputs` uniform buffer with a field for each event, float, long, bool,
// point2d and color.
fn get_isf_data_input_binding(isf: &isf::Isf) -> Option<String> {
    match inputs_require_isf_data_input(&isf.inputs) {
        false => None,
        true => {
            let mut isf_data_input_string =
                "layout(set = 1, binding = 0) uniform IsfDataInputs {\n".to_string();
            for input in &isf.inputs {
                let ty_str = match input.ty {
                    isf::InputType::Event | isf::InputType::Bool(_) => "bool",
                    isf::InputType::Long(_) => "int",
                    isf::InputType::Float(_) => "float",
                    isf::InputType::Point2d(_) => "vec2",
                    isf::InputType::Color(_) => "vec4",
                    isf::InputType::Image
                    | isf::InputType::Audio(_)
                    | isf::InputType::AudioFft(_) => continue,
                };
                isf_data_input_string.push_str(&format!("\t{} {};\n", ty_str, input.name));
            }
            isf_data_input_string.push_str("};\n");
            Some(isf_data_input_string)
        }
    }
}

fn get_isf_textures(isf: &isf::Isf) -> String {
    let img_sampler_str = "layout(set = 2, binding = 0) uniform sampler img_sampler;\n";

    // Create the textures for the "IMPORTED" images.
    let mut binding = 1;
    let mut imported_textures = vec![];
    for name in isf.imported.keys() {
        let s = format!(
            "layout(set = 2, binding = {}) uniform texture2D {};\n",
            binding, name
        );
        imported_textures.push(s);
        binding += 1;
    }

    // Create the `texture2D` bindings for image, audio and audioFFT inputs.
    let mut input_textures = vec![];
    for input in &isf.inputs {
        match input.ty {
            isf::InputType::Image | isf::InputType::Audio(_) | isf::InputType::AudioFft(_) => {}
            _ => continue,
        }
        let s = format!(
            "layout(set = 2, binding = {}) uniform texture2D {};\n",
            binding, input.name
        );
        input_textures.push(s);
        binding += 1;
    }

    // Now create textures for the `PASSES`.
    let mut pass_textures = vec![];
    for pass in &isf.passes {
        let target = match pass.target {
            None => continue,
            Some(ref t) => t,
        };
        let s = format!(
            "layout(set = 2, binding = {}) uniform texture2D {};\n",
            binding, target
        );
        pass_textures.push(s);
        binding += 1;
    }

    [
        img_sampler_str,
        &imported_textures.join(""),
        &input_textures.join(""),
        &pass_textures.join(""),
    ]
    .concat()
}

// Check whether any of the given list of isf inputs would require the `IsfDataInputs`
// uniform.
fn inputs_require_isf_data_input(inputs: &[isf::Input]) -> bool {
    for input in inputs {
        match input.ty {
            isf::InputType::Image | isf::InputType::Audio(_) | isf::InputType::AudioFft(_) => (),
            _ => return true,
        }
    }
    false
}
