use crate::ast::*;
use crate::{Command, CommandLineContext, Id};
use mizer_command_executor::*;
use mizer_fixtures::FixtureId;

impl Command for Select<Fixtures, Single> {
    async fn execute(&self, context: &impl CommandLineContext) -> anyhow::Result<()> {
        context.execute_command(SelectFixturesCommand {
            fixtures: vec![FixtureId::from(&self.target_entity.id)],
        })?;

        Ok(())
    }
}

impl Command for Select<Fixtures, Range> {
    async fn execute(&self, context: &impl CommandLineContext) -> anyhow::Result<()> {
        let fixtures = context.execute_query(ListFixturesQuery)?;
        let ids = fixtures.into_iter()
            .flat_map(|f| {
                let fixture_id = FixtureId::Fixture(f.id);
                if f.current_mode.sub_fixtures.is_empty() {
                    vec![fixture_id]
                } else {
                    let mut sub_fixtures = f.current_mode.sub_fixtures.iter().map(|sf| FixtureId::SubFixture(f.id, sf.id)).collect::<Vec<_>>();
                    sub_fixtures.insert(0, fixture_id);

                    sub_fixtures
                }
            })
            .map(Id::from)
            .collect::<Vec<_>>();

        context.execute_command(SelectFixturesCommand {
            fixtures: self
                .target_entity
                .evaluate_range(&ids)
                .into_iter()
                .map(|id| FixtureId::from(&id))
                .collect(),
        })?;

        Ok(())
    }
}

impl From<&Id> for FixtureId {
    fn from(id: &Id) -> Self {
        match id.depth() {
            1 => FixtureId::Fixture(id.first()),
            2 => FixtureId::SubFixture(id[0], id[1]),
            _ => panic!("Invalid fixture id: {id:?}"),
        }
    }
}

impl From<FixtureId> for Id {
    fn from(id: FixtureId) -> Self {
        match id {
            FixtureId::Fixture(id) => Id::single(id),
            FixtureId::SubFixture(fixture_id, sub_fixture_id) => Id::new([fixture_id, sub_fixture_id]),
        }
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::commands::tests::assert_command;
    use test_case::test_case;

    #[test_case("select fixtures 1")]
    #[test_case("select 1")]
    #[test_case("1")]
    pub fn parse_single(input: &str) {
        let expected = Select {
            target_type: Fixtures,
            target_entity: Single { id: Id::single(1) },
        };

        assert_command(input, expected);
    }

    #[test_case("select fixtures 1.1")]
    #[test_case("select 1.1")]
    #[test_case("1.1")]
    pub fn parse_sub_fixture(input: &str) {
        let expected = Select {
            target_type: Fixtures,
            target_entity: Single { id: Id::new([1, 1]) },
        };

        assert_command(input, expected);
    }
}
