use std::path::Path;

use async_std::io;
use multer::Multipart;
use tide::{Request, Route};

use crate::MediaServer;

use self::serve_dir::ServeDir;

mod add_media;
mod serve_dir;

pub async fn start(media_server_api: MediaServer) -> anyhow::Result<()> {
    let mut app = tide::with_state(media_server_api);
    app.at("/thumbnails/").serve_dir_v2(".storage/thumbnails")?;
    app.at("/media/").serve_dir_v2(".storage/media/")?;
    app.at("/api/media")
        .post(|mut req: Request<MediaServer>| async move {
            let body = req.body_bytes().await;
            // TODO: actually stream file instead copying whole file into memory
            let body = async_std::stream::once(body);
            // TODO: read boundary from request
            let multipart = Multipart::new(body, "boundary");
            add_media::handle(req.state(), multipart).await
        });

    app.listen("0.0.0.0:50050").await?;

    Ok(())
}

trait ServeDirExt {
    fn serve_dir_v2(&mut self, dir: impl AsRef<Path>) -> io::Result<()>;
}

impl<'a> ServeDirExt for Route<'a, MediaServer> {
    fn serve_dir_v2(&mut self, dir: impl AsRef<Path>) -> io::Result<()> {
        // Verify path exists, return error if it doesn't.
        let dir = dir.as_ref().to_owned().canonicalize()?;
        let prefix = self.path().to_string();
        self.at("*").get(ServeDir::new(prefix, dir));
        Ok(())
    }
}
