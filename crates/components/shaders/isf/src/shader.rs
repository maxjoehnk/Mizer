use isf::Isf;
use mizer_shaders::{Shader, ShaderInput, ShaderInputType};
use mizer_wgpu::wgpu::ShaderModuleDescriptor;
use std::borrow::Cow;
use std::path::PathBuf;

pub const ISF_SHADER_TYPE: &str = "ISF";

const DEFAULT_VERTEX_SHADER: &str = include_str!("default.vert");

#[derive(Debug, Clone)]
pub struct IsfShader {
    pub shader: Isf,
    pub fragment_shader: String,
    pub vertex_shader: Option<String>,
    pub filename: String,
    pub path: PathBuf,
}

impl Shader for IsfShader {
    fn shader_type(&self) -> &'static str {
        ISF_SHADER_TYPE
    }

    fn fragment(&self) -> ShaderModuleDescriptor {
        ShaderModuleDescriptor {
            label: Some(&self.filename),
            source: mizer_wgpu::wgpu::ShaderSource::Glsl {
                shader: Cow::Borrowed(&self.fragment_shader),
                stage: naga::ShaderStage::Fragment,
                defines: Default::default(),
            },
        }
    }

    fn vertex(&self) -> ShaderModuleDescriptor {
        let mut label: Option<&str> = None;
        let mut shader = Cow::Borrowed(DEFAULT_VERTEX_SHADER);
        if let Some(source) = self.vertex_shader.as_ref() {
            label = Some(&self.filename);
            shader = Cow::Borrowed(source);
        }

        ShaderModuleDescriptor {
            label,
            source: mizer_wgpu::wgpu::ShaderSource::Glsl {
                shader,
                stage: naga::ShaderStage::Vertex,
                defines: Default::default(),
            },
        }
    }

    fn name(&self) -> String {
        self.filename.clone().replace(".fs", "")
    }

    fn id(&self) -> String {
        self.path.to_string_lossy().into()
    }

    fn inputs(&self) -> Vec<ShaderInput> {
        self.shader
            .inputs
            .iter()
            .filter_map(|input| {
                Some(ShaderInput {
                    name: input.name.clone(),
                    label: input.label.clone(),
                    ty: match input.ty.clone() {
                        isf::InputType::Bool(bool) => ShaderInputType::Bool {
                            default: bool.default,
                        },
                        isf::InputType::Long(long) => ShaderInputType::Long {
                            default: long.default.map(|v| v as i64),
                        },
                        isf::InputType::Float(float) => ShaderInputType::Float {
                            default: float.default.map(|v| v as f64),
                        },
                        isf::InputType::Color(color) => ShaderInputType::Color,
                        isf::InputType::Image => ShaderInputType::Image,
                        input_type => {
                            tracing::warn!("missing input type: {:?}", input_type);

                            return None;
                        }
                    },
                })
            })
            .collect()
    }

    fn categories(&self) -> Vec<String> {
        self.shader.categories.clone()
    }
}

/// Generate the necessary GLSL declarations from the given ISF to be prefixed to the GLSL string
/// from which the ISF was parsed.
///
/// This string should be inserted directly after the version preprocessor.
pub(crate) fn glsl_string_from_isf(isf: &isf::Isf) -> String {
    // The normalised coords passed through from the vertex shader.
    let frag_norm_coord_str = "layout(location = 0) in vec2 isf_FragNormCoord;\n\n";

    // Create the `img_sampler` binding, used for sampling all input images.
    let img_sampler_str = "layout(set = 0, binding = 0) uniform sampler img_sampler;\n";

    // Create the textures for the "IMPORTED" images.
    let mut binding = 1;
    let mut imported_textures = vec![];
    for name in isf.imported.keys() {
        let s = format!(
            "layout(set = 0, binding = {}) uniform texture2D {};\n",
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
            "layout(set = 0, binding = {}) uniform texture2D {};\n",
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
            "layout(set = 0, binding = {}) uniform texture2D {};\n",
            binding, target
        );
        pass_textures.push(s);
        binding += 1;
    }

    // Create the `IsfData` uniform buffer with time, date, etc.
    let isf_data_str = "
layout(set = 1, binding = 0) uniform IsfData {
    int PASSINDEX;
    vec2 RENDERSIZE;
    float TIME;
    float TIMEDELTA;
    vec4 DATE;
    int FRAMEINDEX;
};\n";

    // Create the `IsfDataInputs` uniform buffer with a field for each event, float, long, bool,
    // point2d and color.
    let isf_data_input_str = match inputs_require_isf_data_input(&isf.inputs) {
        false => None,
        true => {
            let mut isf_data_input_string =
                "layout(set = 2, binding = 0) uniform IsfDataInputs {\n".to_string();
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
    };

    // Image functions.
    let img_fns_str = "
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

    // Combine all the declarations together.
    let mut s = String::new();
    s.push_str(frag_norm_coord_str);
    s.push_str(img_sampler_str);
    s.extend(imported_textures);
    s.extend(input_textures);
    s.extend(pass_textures);
    s.push_str(isf_data_str);
    s.extend(isf_data_input_str);
    s.push_str(img_fns_str);
    s
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

/// Check to see if the `gl_FragColor` variable from old GLSL versions exist and if there's no out
/// variable for it. If so, create a variable for it.
///
/// TODO: This should check that `gl_FragColor` doesn't just exist in a comment or behind a
/// pre-existing macro or something. This was originally just added to makes the tests past.
pub fn glfragcolor_exists_and_no_out(glsl_str: &str) -> bool {
    glsl_str.contains("gl_FragColor") && !glsl_str.contains("out vec4 gl_FragColor")
}

/// We can't create allow a `gl_FragColor` out, so in the case we have to rename it we create the
/// out decl for it here.
pub const FRAGCOLOR_OUT_DECL_STR: &str = "layout(location = 0) out vec4 FragColor;\n";

/// Inserts the ISF into the beginning of the shader, returning the resulting glsl source.
pub fn prefix_isf_glsl_str(isf_glsl_str: &str, mut shader_string: String) -> String {
    // Check to see if we need to declare the `gl_FragCoord` output.
    // While we're at it, replace `vv_FragNormCoord` with `isf_FragNormCoord` if necessary.
    let glfragcolor_decl_str = {
        shader_string = shader_string.replace("vv_FragNormCoord", "isf_FragNormCoord");
        if glfragcolor_exists_and_no_out(&shader_string) {
            shader_string = shader_string.replace("gl_FragColor", "FragColor");
            Some(FRAGCOLOR_OUT_DECL_STR.to_string())
        } else {
            None
        }
    };

    // See if the version exists or if it needs to be added.
    enum Version {
        // Where the version currently exists.
        Exists(std::ops::Range<usize>),
        // The version string that needs to be added.
        NeedsToBeAdded(&'static str),
    }
    // TODO: This will break if there's a commented line like `//#version` before the actual
    // version. This caveat is possibly worth the massive speedup we gain by not parsing with
    // `glsl` crate.
    let version = if let Some(start) = shader_string.find("#version ") {
        let version_line = shader_string[start..]
            .lines()
            .next()
            .expect("failed to retrieve version line");
        let end = start + version_line.len();
        Version::Exists(start..end)
    } else {
        Version::NeedsToBeAdded("#version 450\n")
    };

    // The output string we will fill and return.
    let mut output = String::new();

    // Add the version to the top. Grab the remaining part of the shader string yet to be added.
    let remaining_shader_str = match version {
        Version::NeedsToBeAdded(s) => {
            output.push_str(s);
            &shader_string
        }
        Version::Exists(range) => {
            output.push_str(&format!("{}\n", &shader_string[range.clone()]));
            &shader_string[range.end..]
        }
    };

    output.extend(glfragcolor_decl_str);
    output.push_str(isf_glsl_str);
    output.push_str(remaining_shader_str);
    output
}
