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
    pub offset: u16,
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
