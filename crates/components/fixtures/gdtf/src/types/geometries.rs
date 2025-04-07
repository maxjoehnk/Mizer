use crate::types::DmxChannelOffset;
use hard_xml::XmlRead;
use serde_derive::Serialize;
use std::collections::HashMap;

#[derive(Debug, Clone, XmlRead, Serialize)]
#[xml(tag = "Geometries")]
pub struct Geometries {
    #[xml(
        child = "Geometry",
        child = "Beam",
        child = "Axis",
        child = "GeometryReference"
    )]
    pub children: Vec<GeometryType>,
}

#[derive(Debug, Clone, XmlRead, Serialize)]
pub enum GeometryType {
    #[xml(tag = "Geometry")]
    Geometry(Geometry),
    #[xml(tag = "Beam")]
    Beam(Beam),
    #[xml(tag = "Axis")]
    Axis(Axis),
    #[xml(tag = "GeometryReference")]
    GeometryReference(GeometryReference),
}

#[derive(Debug, Clone, XmlRead, Serialize)]
#[xml(tag = "GeometryReference")]
pub struct GeometryReference {
    #[xml(attr = "Name")]
    pub name: String,
    #[xml(attr = "Geometry")]
    pub geometry: String,
    #[xml(attr = "Model")]
    pub model: Option<String>,
    #[xml(child = "Break")]
    pub dmx_breaks: Vec<ReferenceDmxBreak>,
}

#[derive(Debug, Clone, XmlRead, Serialize)]
#[xml(tag = "Break")]
pub struct ReferenceDmxBreak {
    #[xml(attr = "DMXBreak")]
    pub dmx_break: u64,
    #[xml(attr = "DMXOffset")]
    pub offset: DmxChannelOffset,
}

impl GeometryType {
    fn name(&self) -> &str {
        match self {
            GeometryType::Geometry(geometry) => &geometry.name,
            GeometryType::Beam(beam) => &beam.name,
            GeometryType::Axis(axis) => &axis.name,
            GeometryType::GeometryReference(reference) => &reference.name,
        }
    }

    fn find(&self, name: &str) -> Option<&GeometryType> {
        if self.name() == name {
            return Some(&self);
        }
        match self {
            GeometryType::Geometry(geometry) => {
                geometry.children.iter().filter_map(|g| g.find(name)).next()
            }
            GeometryType::Beam(geometry) => {
                geometry.children.iter().filter_map(|g| g.find(name)).next()
            }
            GeometryType::Axis(axis) => axis.children.iter().filter_map(|g| g.find(name)).next(),
            GeometryType::GeometryReference(_) => None,
        }
    }

    fn first_beam(&self) -> Option<&Beam> {
        match self {
            GeometryType::Geometry(geometry) => {
                geometry.children.iter().find_map(|g| g.first_beam())
            }
            GeometryType::Beam(beam) => Some(beam),
            GeometryType::Axis(axis) => axis.children.iter().find_map(|g| g.first_beam()),
            GeometryType::GeometryReference(_) => None,
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
            GeometryType::Axis(axis) => {
                for child in axis.children.iter() {
                    beams += child.count_beams(should_include);
                }
            }
            GeometryType::GeometryReference(_) => {}
        }

        beams
    }
}

#[derive(Debug, Clone, XmlRead, Serialize)]
#[xml(tag = "Geometry")]
pub struct Geometry {
    #[xml(attr = "Name")]
    pub name: String,
    #[xml(attr = "Model")]
    pub model: Option<String>,
    #[xml(
        child = "Geometry",
        child = "Beam",
        child = "Axis",
        child = "GeometryReference"
    )]
    pub children: Vec<GeometryType>,
}

#[derive(Debug, Clone, XmlRead, Serialize)]
#[xml(tag = "Beam")]
pub struct Beam {
    #[xml(attr = "Name")]
    pub name: String,
    #[xml(
        child = "Geometry",
        child = "Beam",
        child = "Axis",
        child = "GeometryReference"
    )]
    pub children: Vec<GeometryType>,
}

#[derive(Debug, Clone, XmlRead, Serialize)]
#[xml(tag = "Axis")]
pub struct Axis {
    #[xml(attr = "Name")]
    pub name: String,
    #[xml(
        child = "Geometry",
        child = "Beam",
        child = "Axis",
        child = "GeometryReference"
    )]
    pub children: Vec<GeometryType>,
}

impl Axis {
    pub fn child_beams(&self) -> Vec<&Beam> {
        self.children
            .iter()
            .flat_map(|g| match g {
                GeometryType::Beam(beam) => vec![vec![beam], beam.child_beams()].concat(),
                GeometryType::Geometry(geometry) => geometry.child_beams(),
                GeometryType::Axis(axis) => axis.child_beams(),
                GeometryType::GeometryReference(_) => vec![],
            })
            .collect()
    }

    pub fn child_names(&self) -> Vec<&str> {
        self.children
            .iter()
            .flat_map(|g| match g {
                GeometryType::Beam(beam) => {
                    vec![vec![beam.name.as_str()], beam.child_names()].concat()
                }
                GeometryType::Geometry(geometry) => {
                    vec![vec![geometry.name.as_str()], geometry.child_names()].concat()
                }
                GeometryType::Axis(axis) => {
                    vec![vec![axis.name.as_str()], axis.child_names()].concat()
                }
                GeometryType::GeometryReference(_) => vec![],
            })
            .collect()
    }
}

impl Beam {
    pub fn child_beams(&self) -> Vec<&Beam> {
        self.children
            .iter()
            .flat_map(|g| match g {
                GeometryType::Beam(beam) => vec![vec![beam], beam.child_beams()].concat(),
                GeometryType::Geometry(geometry) => geometry.child_beams(),
                GeometryType::Axis(axis) => axis.child_beams(),
                GeometryType::GeometryReference(_) => vec![],
            })
            .collect()
    }

    pub fn child_names(&self) -> Vec<&str> {
        self.children
            .iter()
            .flat_map(|g| match g {
                GeometryType::Beam(beam) => {
                    vec![vec![beam.name.as_str()], beam.child_names()].concat()
                }
                GeometryType::Geometry(geometry) => {
                    vec![vec![geometry.name.as_str()], geometry.child_names()].concat()
                }
                GeometryType::Axis(axis) => {
                    vec![vec![axis.name.as_str()], axis.child_names()].concat()
                }
                GeometryType::GeometryReference(_) => vec![],
            })
            .collect()
    }
}

impl Geometry {
    fn child_beams(&self) -> Vec<&Beam> {
        self.children
            .iter()
            .flat_map(|g| match g {
                GeometryType::Beam(beam) => vec![vec![beam], beam.child_beams()].concat(),
                GeometryType::Geometry(geometry) => geometry.child_beams(),
                GeometryType::Axis(axis) => axis.child_beams(),
                GeometryType::GeometryReference(_) => vec![],
            })
            .collect()
    }

    fn child_names(&self) -> Vec<&str> {
        self.children
            .iter()
            .flat_map(|g| match g {
                GeometryType::Beam(beam) => {
                    vec![vec![beam.name.as_str()], beam.child_names()].concat()
                }
                GeometryType::Geometry(geometry) => {
                    vec![vec![geometry.name.as_str()], geometry.child_names()].concat()
                }
                GeometryType::Axis(axis) => {
                    vec![vec![axis.name.as_str()], axis.child_names()].concat()
                }
                GeometryType::GeometryReference(_) => vec![],
            })
            .collect()
    }
}

impl Geometries {
    pub fn get_root(&self, name: &str) -> Option<DmxModeGeometry> {
        let root = self.children.iter().find(|g| g.name() == name)?;

        Some(DmxModeGeometry::new(root, self))
    }

    pub fn get_geometry(&self) -> Option<DmxModeGeometry> {
        let root = self.children.iter().next()?;

        Some(DmxModeGeometry::new(root, self))
    }
}

#[derive(Debug, Serialize)]
pub struct DmxModeGeometry {
    root: ResolvedGeometry,
}

// This struct should look up all GeometryReferences and provide a object representing the actual fixture geometry so it can be properly mapped
impl DmxModeGeometry {
    fn new(root: &GeometryType, geometries: &Geometries) -> Self {
        Self {
            root: ResolvedGeometry::resolve(root, geometries),
        }
    }

    // instead of first beam there should be a way to get the "parent" fixture attributes
    // everything below should then be mapped to sub fixtures
    //
    // Example for Otos W3
    // Base Yoke and Head are parent attributes
    // Every beam in the plate is a sub fixture
    // Every beam in the ring is a sub fixture
    pub fn root_beam(&self) -> Option<&Beam> {
        None
        // self.root.first_beam()
    }

    pub fn count_beams(&self, should_include: impl Fn(&str) -> bool) -> usize {
        0
        // self.root.count_beams(&should_include)
    }
}

impl IGeometry for DmxModeGeometry {
    fn name(&self) -> &str {
        self.root.name()
    }

    fn children(&self) -> Vec<&dyn IGeometry> {
        self.root.children()
    }

    fn has_beams(&self) -> bool {
        self.root.children().iter().any(|c| c.has_beams())
    }

    fn feature(&self) -> GeometryFeature {
        self.root.feature()
    }
}

impl IGeometry for ResolvedGeometry {
    fn name(&self) -> &str {
        &self.name
    }

    fn children(&self) -> Vec<&dyn IGeometry> {
        match &self.geometry {
            ResolvedGeometryType::Geometry { children, .. } => children
                .iter()
                .map(|g| g as &dyn IGeometry)
                .collect(),
            ResolvedGeometryType::Beam { children, .. } => children.iter().map(|g| g as &dyn IGeometry).collect(),
            ResolvedGeometryType::Axis { children, .. } => children.iter().map(|g| g as &dyn IGeometry).collect(),
            ResolvedGeometryType::GeometryReference { geometry } => vec![geometry.as_ref() as &dyn IGeometry],
        }
    }

    fn has_beams(&self) -> bool {
        match &self.geometry {
            ResolvedGeometryType::Geometry { children, .. } => children.iter().any(|g| g.has_beams()),
            ResolvedGeometryType::Beam { .. } => true,
            ResolvedGeometryType::Axis { children, .. } => children.iter().any(|g| g.has_beams()),
            ResolvedGeometryType::GeometryReference { geometry } => geometry.has_beams(),
        }
    }

    fn feature(&self) -> GeometryFeature {
        GeometryFeature {
            name: self.name.clone(),
            dmx_breaks: self.dmx_breaks.clone(),
        }
    }
}

impl GeometryReference {
    fn feature(&self) -> GeometryFeature {
        GeometryFeature {
            name: self.name.clone(),
            dmx_breaks: self.dmx_breaks.clone(),
        }
    }
}

pub trait IGeometry {
    fn name(&self) -> &str;
    fn children(&self) -> Vec<&dyn IGeometry>;

    fn has_beams(&self) -> bool;

    fn feature(&self) -> GeometryFeature;

    fn root_features(&self) -> GeometryFeatures
    where
        Self: Sized,
    {
        let mut features = GeometryFeatures::default();
        features.add(self);
        let mut root: &dyn IGeometry = self;

        let mut children = root.children();
        while (children.iter().filter(|c| c.has_beams()).count()) == 1 {
            let child = children.iter().find(|c| c.has_beams()).unwrap();
            features.add(*child);
            root = *child;

            children = root.children();
        }

        features
    }

    fn lowest_parent(&self) -> Option<&dyn IGeometry> where Self: Sized {
        let mut root: &dyn IGeometry = self;

        let mut children = root.children();
        while (children.iter().filter(|c| c.has_beams()).count()) == 1 {
            let child = children.iter().find(|c| c.has_beams()).unwrap();
            root = *child;

            children = root.children();
        }

        Some(root)
    }
}

#[derive(Default, Clone, Debug, Serialize)]
pub struct GeometryFeatures {
    features: HashMap<String, GeometryFeature>,
}

impl GeometryFeatures {
    fn add(&mut self, geometry: &dyn IGeometry) {
        self.features
            .insert(geometry.name().to_string(), geometry.feature());
    }

    pub fn features(&self) -> impl Iterator<Item = &GeometryFeature> {
        self.features.values()
    }
}

#[derive(Clone, Debug, Serialize)]
pub struct GeometryFeature {
    pub name: String,
    pub dmx_breaks: Vec<ReferenceDmxBreak>,
}

#[derive(Clone, Debug, Serialize)]
pub struct ResolvedGeometry {
    pub name: String,
    pub geometry: ResolvedGeometryType,
    pub dmx_breaks: Vec<ReferenceDmxBreak>,
}

impl ResolvedGeometry {
    fn resolve(root: &GeometryType, geometries: &Geometries) -> Self {
        root.resolve(geometries)
    }
}

impl GeometryType {
    fn resolve(&self, geometries: &Geometries) -> ResolvedGeometry {
        match self {
            GeometryType::Geometry(geometry) => {
                let children = geometry
                    .children
                    .iter()
                    .map(|g| g.resolve(geometries))
                    .collect::<Vec<_>>();

                ResolvedGeometry {
                    name: geometry.name.clone(),
                    geometry: ResolvedGeometryType::Geometry {
                        children,
                    },
                    dmx_breaks: Default::default(),
                }
            }
            GeometryType::Beam(beam) => {
                let children = beam
                    .children
                    .iter()
                    .map(|g| g.resolve(geometries))
                    .collect::<Vec<_>>();

                ResolvedGeometry {
                    name: beam.name.clone(),
                    geometry: ResolvedGeometryType::Beam {
                        children,
                    },
                    dmx_breaks: Default::default(),
                }
            }
            GeometryType::Axis(axis) => {
                let children = axis
                    .children
                    .iter()
                    .map(|g| g.resolve(geometries))
                    .collect::<Vec<_>>();

                ResolvedGeometry {
                    name: axis.name.clone(),
                    geometry: ResolvedGeometryType::Axis {
                        children,
                    },
                    dmx_breaks: Default::default(),
                }
            }
            GeometryType::GeometryReference(reference) => {
                let geometry = geometries.resolve(&reference.geometry).unwrap();
                let mut geometry = geometry.resolve(geometries);

                geometry.dmx_breaks = reference.dmx_breaks.clone();

                ResolvedGeometry {
                    name: reference.name.clone(),
                    geometry: ResolvedGeometryType::GeometryReference {
                        geometry: Box::new(geometry)
                    },
                    dmx_breaks: Default::default(),
                }
            }
        }
    }
}

impl Geometries {
    fn resolve(&self, name: &str) -> Option<GeometryType> {
        self.children.iter().find(|g| g.name() == name).cloned()
    }
}

#[derive(Clone, Debug, Serialize)]
pub enum ResolvedGeometryType {
    Geometry {
        children: Vec<ResolvedGeometry>,
    },
    Beam {
        children: Vec<ResolvedGeometry>,
    },
    Axis {
        children: Vec<ResolvedGeometry>,
    },
    GeometryReference {
        geometry: Box<ResolvedGeometry>,
    }
}
