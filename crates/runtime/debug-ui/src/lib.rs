pub mod noop;

pub trait DebugUiRenderHandle<'a> {
    type DrawHandle<'b>: DebugUiDrawHandle<'b>;
    type TextureMap;

    fn draw(&mut self, call: impl FnOnce(&mut Self::DrawHandle<'_>, &mut Self::TextureMap));
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
        add_content: impl FnOnce(&mut Self::DrawHandle<'_>),
    );

    fn columns(&mut self, count: usize, add_contents: impl FnOnce(&mut [Self::DrawHandle<'_>]));

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
