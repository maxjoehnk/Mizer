use std::fmt::Display;

use citp::protocol::WriteToBytes;

use mizer_fixtures::manager::FixtureManager;

mod caex;
mod pinf;
mod sdmx;

pub fn get_handlers(
    fixture_manager: Option<FixtureManager>,
) -> Vec<Box<dyn CitpMessageHandlerDyn>> {
    vec![
        Box::new(pinf::NameHandler),
        Box::new(caex::FixtureListRequestHandler::new(fixture_manager)),
        Box::new(caex::EnterShowHandler),
        Box::new(caex::LeaveShowHandler),
        Box::new(caex::GetLaserFeedListHandler),
        Box::new(sdmx::CapabilitiesHandler),
    ]
}

pub trait CitpMessageHandler {
    const FIRST_HEADER_CONTENT_TYPE: &'static [u8; 4];
    const SECOND_HEADER_CONTENT_TYPE: &'static [u8; 4];

    type Result<'a>: Into<CitpMessageResult>
    where
        Self: 'a;

    fn can_handle(&self, header: &[u8; 4], second_header: &[u8; 4]) -> bool {
        header == Self::FIRST_HEADER_CONTENT_TYPE
            && second_header == Self::SECOND_HEADER_CONTENT_TYPE
    }

    fn handle<'a>(&'a self, data: &[u8]) -> anyhow::Result<Self::Result<'a>>;

    fn announce<'a>(&'a self) -> anyhow::Result<Option<Self::Result<'a>>> {
        Ok(None)
    }
}

pub trait CitpMessageHandlerDyn: Display + Send + Sync {
    fn can_handle(&self, header: &[u8; 4], second_header: &[u8; 4]) -> bool;
    fn handle(&self, data: &[u8]) -> anyhow::Result<Vec<u8>>;
    fn announce(&self) -> anyhow::Result<Option<Vec<u8>>>;
}

impl<T: CitpMessageHandler + Display + Send + Sync> CitpMessageHandlerDyn for T {
    fn can_handle(&self, header: &[u8; 4], second_header: &[u8; 4]) -> bool {
        CitpMessageHandler::can_handle(self, header, second_header)
    }

    fn handle(&self, data: &[u8]) -> anyhow::Result<Vec<u8>> {
        let result = CitpMessageHandler::handle(self, data)?;
        let result = result.into();

        Ok(result.0)
    }

    fn announce(&self) -> anyhow::Result<Option<Vec<u8>>> {
        let result = CitpMessageHandler::announce(self)?;
        let result = result.map(|result| result.into());
        let result = result.map(|d| d.0);

        Ok(result)
    }
}

#[derive(Default)]
pub struct CitpMessageResult(Vec<u8>);

pub(crate) trait InternalWriteToBytes: WriteToBytes {}

impl From<()> for CitpMessageResult {
    fn from(_: ()) -> Self {
        Self(Vec::new())
    }
}

impl<T: InternalWriteToBytes> From<T> for CitpMessageResult {
    fn from(value: T) -> Self {
        let mut bytes = Vec::new();
        value.write_to_bytes(&mut bytes).unwrap();
        Self(bytes)
    }
}

#[macro_export]
macro_rules! handler_name {
    ($module:ty) => {
        impl std::fmt::Display for $module {
            fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
                f.write_str(stringify!($module).trim())
            }
        }
    };
}
