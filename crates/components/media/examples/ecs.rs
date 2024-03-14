use std::time::Duration;
use tracing::Level;
use mizer_ecs::*;
use mizer_media::ecs::*;
use mizer_media::MediaDiscovery;

#[tokio::main]
async fn main() {
    let _ = tracing::subscriber::set_global_default(
        tracing_subscriber::fmt()
            .with_max_level(Level::TRACE)
            .finish(),
    );
    
    let mut context = EcsContext::new();
    let import_handle = setup(&mut context);
    
    let discovery = MediaDiscovery::new(import_handle, "/Users/maxjoehnk/Documents/Mizer/Visuals");
    tokio::spawn(async move {
        discovery.discover().await.unwrap();
    });
    
    loop {
        context.run();
        
        let views = context.get_media_views();
        
        tracing::debug!("Views: {views:?}");
        
        tokio::time::sleep(Duration::from_secs(1)).await;
    }
}
