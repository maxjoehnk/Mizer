use crate::{CommandLineContext, Id};
use mizer_command_executor::ListFixturesQuery;
use mizer_fixtures::FixtureId;

mod call_group;
mod clear;
mod delete_group;
mod delete_sequence;
mod go_sequence;
mod highlight;
mod off_sequence;
mod select_fixtures;
mod store_group;
mod write_programmer;
mod delete_cue;

#[cfg(test)]
mod tests {
    use crate::{try_parse_as_command, Command, CommandLineContext};
    use mizer_command_executor::{SendableCommand, SendableQuery};

    struct TestContext;

    impl CommandLineContext for TestContext {
        fn execute_command<'a>(
            &self,
            _command: impl SendableCommand<'a> + 'static,
        ) -> anyhow::Result<()> {
            todo!()
        }

        fn execute_query<'a, TQuery: SendableQuery<'a> + 'static>(
            &self,
            query: TQuery,
        ) -> anyhow::Result<TQuery::Result> {
            todo!()
        }
    }

    pub fn assert_command<TCommand: Command + 'static>(input: &str, expected: TCommand) {
        let command = try_parse_as_command::<TestContext>(input).unwrap();
        let command = command.downcast::<TCommand>().unwrap();

        let expected = Box::new(expected);

        assert_eq!(command, expected);
    }
}

trait CommandLineContextFixtureExt {
    fn fixture_ids(&self) -> anyhow::Result<Vec<Id>>;
}

impl<T: CommandLineContext> CommandLineContextFixtureExt for T {
    fn fixture_ids(&self) -> anyhow::Result<Vec<Id>> {
        let fixtures = self.execute_query(ListFixturesQuery)?;
        let ids = fixtures
            .into_iter()
            .flat_map(|f| {
                let fixture_id = FixtureId::Fixture(f.id);
                if f.current_mode.sub_fixtures.is_empty() {
                    vec![fixture_id]
                } else {
                    let mut sub_fixtures = f
                        .current_mode
                        .sub_fixtures
                        .iter()
                        .map(|sf| FixtureId::SubFixture(f.id, sf.id))
                        .collect::<Vec<_>>();
                    sub_fixtures.insert(0, fixture_id);

                    sub_fixtures
                }
            })
            .map(Id::from)
            .collect();

        Ok(ids)
    }
}
