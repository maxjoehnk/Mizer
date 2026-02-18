pub use mizer_injector::Injector;
use std::any::Any;
use mizer_injector::InjectionScope;

pub mod noop;

pub trait DebugUiRenderHandle<'a> {
    type DrawHandle<'b>: DebugUiDrawHandle<'b>;
    type TextureMap;

    fn draw(&mut self, injector: &InjectionScope, state_access: &dyn NodeStateAccess);
}

/// This trait is a hack, so we can access the state of nodes in a debug ui pane.
pub trait NodeStateAccess {
    fn get(&self, path: &str) -> Option<&Box<dyn Any>>;
}

pub trait DebugUi {
    type RenderHandle<'a, 'b>: DebugUiRenderHandle<
        'a,
        DrawHandle<'b> = Self::DrawHandle<'b>,
        TextureMap = Self::TextureMap,
    >
    where
        Self: 'a,
        Self: 'b;
    type DrawHandle<'a>: DebugUiDrawHandle<'a, TextureMap = Self::TextureMap>
    where
        Self: 'a;
    type TextureMap;

    fn pre_render(&mut self) -> Self::RenderHandle<'_, '_>;

    fn render(&mut self);
}

pub trait DebugUiDrawHandle<'a> {
    type Response: DebugUiResponse;
    type DrawHandle<'b>: DebugUiDrawHandle<'b>;
    type TextureMap;

    fn horizontal(&mut self, cb: impl FnOnce(&mut Self::DrawHandle<'_>));

    fn button(&mut self, text: impl Into<String>) -> Self::Response;

    fn heading(&mut self, text: impl Into<String>);

    fn label(&mut self, text: impl Into<String>);

    fn collapsing_header(
        &mut self,
        title: impl Into<String>,
        key: Option<&'_ str>,
        add_content: impl FnOnce(&mut Self::DrawHandle<'_>),
    );

    fn columns(&mut self, count: usize, add_contents: impl FnOnce(&mut [Self::DrawHandle<'_>]));

    fn progress_bar(&mut self, progress: f32);

    fn plot(&mut self, id: &'static str, min: f64, max: f64, values: &[f64]);

    fn image<I: std::hash::Hash>(
        &mut self,
        image_id: I,
        data: &[u8],
        textures: &mut Self::TextureMap,
    );
}

pub trait DebugUiResponse {
    fn clicked(&self) -> bool;
}

pub trait DebugUiPane<TUi: DebugUi> {
    fn title(&self) -> &'static str;

    fn render<'a>(
        &mut self,
        injector: &InjectionScope<'a>,
        state_access: &dyn NodeStateAccess,
        ui: &mut TUi::DrawHandle<'a>,
        textures: &mut <TUi::DrawHandle<'a> as DebugUiDrawHandle<'a>>::TextureMap,
    );
}
