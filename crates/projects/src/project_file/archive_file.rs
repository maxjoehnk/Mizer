use std::io::{Cursor, Read, Write};

use zip::{ZipArchive, ZipWriter};

#[derive(Default)]
pub(crate) struct ProjectArchive(pub(crate) Vec<u8>);

impl ProjectArchive {
    pub fn new() -> Self {
        Self::default()
    }
    
    pub fn read(&self) -> anyhow::Result<ProjectArchiveReader> {
        let archive = ZipArchive::new(Cursor::new(self.0.as_slice()))?;

        Ok(ProjectArchiveReader(archive))
    }

    pub fn write(&mut self) -> anyhow::Result<ProjectArchiveWriter> {
        let archive = if self.0.is_empty() {
            ZipWriter::new(Cursor::new(&mut self.0))
        }else {
            ZipWriter::new_append(Cursor::new(&mut self.0))?
        };

        Ok(ProjectArchiveWriter(archive))
    }
}

pub(crate) struct ProjectArchiveReader<'a>(ZipArchive<Cursor<&'a [u8]>>);

impl<'a> ProjectArchiveReader<'a> {
    pub fn read_file(&mut self, file_name: &str) -> anyhow::Result<impl Read + '_> {
        Ok(self.0.by_name(file_name)?)
    }
}

pub(crate) struct ProjectArchiveWriter<'a>(ZipWriter<Cursor<&'a mut Vec<u8>>>);

impl<'a> ProjectArchiveWriter<'a> {
    pub fn write_file(&mut self, file_name: &str) -> anyhow::Result<()> {
        self.0.start_file::<_, (), _>(file_name, Default::default())?;
        
        Ok(())
    }
}

impl<'a> Write for ProjectArchiveWriter<'a> {
    fn write(&mut self, buf: &[u8]) -> std::io::Result<usize> {
        self.0.write(buf)
    }

    fn flush(&mut self) -> std::io::Result<()> {
        self.0.flush()
    }
}
