use crate::models::*;
use crate::RuntimeApi;
use futures::{Stream, StreamExt};
use protobuf::SingularPtrField;

#[derive(Clone)]
pub struct SessionHandler<R: RuntimeApi> {
    runtime: R,
}

impl<R: RuntimeApi> SessionHandler<R> {
    pub fn new(runtime: R) -> Self {
        Self { runtime }
    }

    pub fn watch_session(&self) -> anyhow::Result<impl Stream<Item = Session>> {
        let stream = self
            .runtime
            .observe_session()?
            .into_stream()
            .map(|state| Session {
                _filePath: state.project_path.map(Session_oneof__filePath::from),
                projectHistory: state.project_history.into(),
                devices: vec![SessionDevice {
                    name: "max-arch".into(),
                    ping: 0f64,
                    ips: vec!["192.168.1.13".to_string()].into(),
                    clock: SingularPtrField::some(DeviceClock {
                        drift: 0f64,
                        master: true,
                        ..Default::default()
                    }),
                    ..Default::default()
                }]
                .into(),
                ..Default::default()
            });

        Ok(stream)
    }

    pub fn new_project(&self) -> anyhow::Result<()> {
        self.runtime.new_project()
    }

    pub fn load_project(&self, path: String) -> anyhow::Result<()> {
        self.runtime.load_project(path)
    }

    pub fn save_project(&self) -> anyhow::Result<()> {
        self.runtime.save_project()
    }

    pub fn save_project_as(&self, path: String) -> anyhow::Result<()> {
        self.runtime.save_project_as(path)
    }
}
