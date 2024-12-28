use std::any::Any;
use std::time::Instant;

use derive_more::From;

use mizer_commander::{ExtractDependenciesQuery, Query};

pub use get_history::*;
pub use mizer_connection_queries::*;
pub use mizer_fixture_queries::*;
pub use mizer_layout_queries::*;
pub use mizer_media::queries::*;
pub use mizer_plan::queries::*;
pub use mizer_runtime::queries::*;
pub use mizer_sequencer_queries::*;
pub use mizer_timecode::queries::*;

use mizer_module::Inject;

mod get_history;

pub trait SendableQuery<'a>: Query<'a> + Into<QueryImpl> + Send + Sync {}

impl<'a, T: Query<'a> + Into<QueryImpl> + Send + Sync> SendableQuery<'a> for T {}

macro_rules! query_impl {
    ($($x:ident,)*) => {
        #[derive(Debug, From)]
        pub enum QueryImpl {
            $($x($x),)*
        }

        impl QueryImpl {
            pub(crate) fn query(
                &self,
                injector: &impl Inject,
            ) -> anyhow::Result<Box<dyn Any + Send + Sync>> {
                match &self {
                    $(Self::$x(query) => self._query(injector, query),)*
                }
            }
        }
    }
}

query_impl! {
    ListSequencesQuery,
    GetSequenceQuery,
    ListEffectsQuery,
    ListMidiDeviceProfilesQuery,
    ListConnectionsQuery,
    GetCommandHistoryQuery,
    ListFixtureDefinitionsQuery,
    GetFixtureDefinitionQuery,
    ListFixturesQuery,
    ListGroupsQuery,
    ListIntensityPresetsQuery,
    ListPositionPresetsQuery,
    ListShutterPresetsQuery,
    ListColorPresetsQuery,
    ListPlansQuery,
    ListLayoutsQuery,
    ListMediaFilesQuery,
    ListMediaFoldersQuery,
    ListMediaTagsQuery,
    ListTimecodeControlsQuery,
    ListTimecodeTracksQuery,
    ListNodesQuery,
    GetNodeQuery,
    ListLinksQuery,
    ListAvailableNodesQuery,
    ListCommentsQuery,
}

impl QueryImpl {
    fn _query<'a, T: Query<'a> + 'static>(
        &self,
        injector: &'a impl Inject,
        query: &T,
    ) -> anyhow::Result<Box<dyn Any + Send + Sync>> {
        let before = Instant::now();
        let dependencies = T::Dependencies::extract(injector);
        let result = query.query(dependencies);
        let after = Instant::now();
        tracing::debug!("Executed query {query:?} in {:?}", after - before);

        Ok(Box::new(result?))
    }
}
