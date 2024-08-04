use hard_xml::XmlRead;

#[derive(Debug, Clone, XmlRead)]
#[xml(tag = "Geometries")]
pub struct Geometries {
    #[xml(child = "Geometry", child = "Beam")]
    pub children: Vec<GeometryType>,
}

#[derive(Debug, Clone, XmlRead)]
pub enum GeometryType {
    #[xml(tag = "Geometry")]
    Geometry(Geometry),
    #[xml(tag = "Beam")]
    Beam(Beam),
}

impl GeometryType {
    fn name(&self) -> &str {
        match self {
            GeometryType::Geometry(geometry) => &geometry.name,
            GeometryType::Beam(beam) => &beam.name,
        }
    }

    fn find(&self, name: &str) -> Option<&GeometryType> {
        if self.name() == name {
            return Some(&self);
        }
        match self {
            GeometryType::Geometry(geometry) => geometry.children.iter().filter_map(|g| g.find(name)).next(),
            GeometryType::Beam(geometry) => geometry.children.iter().filter_map(|g| g.find(name)).next(),
        }
    }

    pub fn count_beams(&self, should_include: &impl Fn(&str) -> bool) -> usize {
        let mut beams = 0;

        match self {
            GeometryType::Geometry(geometry) => {
                for child in geometry.children.iter() {
                    beams += child.count_beams(should_include);
                }
            }
            GeometryType::Beam(beam) => {
                if should_include(&beam.name) {
                    beams += 1;
                }
                for child in beam.children.iter() {
                    beams += child.count_beams(should_include);
                }
            }
        }

        beams
    }
}

#[derive(Debug, Clone, XmlRead)]
#[xml(tag = "Geometry")]
pub struct Geometry {
    #[xml(attr = "Name")]
    pub name: String,
    #[xml(attr = "Model")]
    pub model: Option<String>,
    #[xml(child = "Geometry", child = "Beam")]
    pub children: Vec<GeometryType>,
}

#[derive(Debug, Clone, XmlRead)]
#[xml(tag = "Beam")]
pub struct Beam {
    #[xml(attr = "Name")]
    pub name: String,
    #[xml(child = "Geometry", child = "Beam")]
    pub children: Vec<GeometryType>,
}

impl Geometries {
    pub fn find(&self, name: &str) -> Option<&GeometryType> {
        self.children.iter().flat_map(|g| g.find(name)).next()
    }

    pub fn count_beams(&self, should_include: impl Fn(&str) -> bool) -> usize {
        let mut beams = 0;

        for child in self.children.iter() {
            beams += child.count_beams(&should_include);
        }

        beams
    }
}
