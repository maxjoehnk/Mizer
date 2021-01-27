use std::fs::File;
use std::path::Path;
use ilda_idtf::*;
use crate::laser::{LaserFrame, LaserPoint, LaserCoordinate, LaserColor};
use ilda_idtf::layout::{Coords2dTrueColor, Coords2d, Color};

pub enum IldaMediaReader {
    FileReader(SectionReader<File>)
}

impl IldaMediaReader {
    pub fn open_file<T: AsRef<Path>>(path: T) -> anyhow::Result<Self> {
        let file = File::open(path)?;
        let reader = SectionReader::new(file);

        Ok(IldaMediaReader::FileReader(reader))
    }

    pub fn read_frames(&mut self) -> anyhow::Result<Vec<LaserFrame>> {
        match self {
            IldaMediaReader::FileReader(reader) => IldaMediaReader::read_to_frames(reader),
        }
    }

    fn read_to_frames<T>(reader: &mut SectionReader<T>) -> anyhow::Result<Vec<LaserFrame>> {
        let mut frames = vec![];
        while let Some(section) = reader.read_next()? {
            match section.reader {
                SubsectionReaderKind::ColorPalette(mut r) => {
                    while let Some(color) = r.read_next()? {
                        println!("palette: {:?}", color);
                    }
                }
                SubsectionReaderKind::Coords2dIndexedColor(mut r) => {
                    while let Some(point) = r.read_next()? {
                        println!("{:?}", point);
                    }
                }
                SubsectionReaderKind::Coords3dIndexedColor(mut r) => {
                    while let Some(point) = r.read_next()? {
                        println!("{:?}", point);
                    }
                }
                SubsectionReaderKind::Coords2dTrueColor(mut r) => {
                    let mut points = vec![];
                    while let Some(point) = r.read_next()? {
                        points.push((*point).into());
                    }
                    frames.push(LaserFrame { points });
                }
                SubsectionReaderKind::Coords3dTrueColor(mut r) => {
                    while let Some(point) = r.read_next()? {
                        println!("{:?}", point);
                    }
                }
            }
        }
        Ok(frames)
    }
}

impl From<Coords2dTrueColor> for LaserPoint {
    fn from(point: Coords2dTrueColor) -> Self {
        LaserPoint {
            coordinate: point.coords.into(),
            color: point.color.into(),
        }
    }
}

impl From<Coords2d> for LaserCoordinate {
    fn from(coord: Coords2d) -> Self {
        LaserCoordinate {
            x: coord.x.get(),
            y: coord.y.get()
        }
    }
}

impl From<Color> for LaserColor {
    fn from(color: Color) -> Self {
        LaserColor {
            red: color.red,
            green: color.green,
            blue: color.blue
        }
    }
}
