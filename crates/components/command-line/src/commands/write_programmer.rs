use crate::ast::*;
use crate::commands::CommandLineContextFixtureExt;
use crate::{Command, CommandLineContext};
use mizer_command_executor::*;
use mizer_fixtures::definition::FixtureControlValue;
use mizer_fixtures::FixtureId;

impl Command for Write<Fixtures, Single, Value> {
    async fn execute(&self, context: &impl CommandLineContext) -> anyhow::Result<()> {
        context.execute_command(SelectFixturesCommand {
            fixtures: vec![FixtureId::from(&self.target_entity.id)],
        })?;
        context.execute_command(WriteProgrammerCommand {
            value: FixtureControlValue::Intensity(self.value.0 as f64 / 100.0),
        })?;

        Ok(())
    }
}

impl Command for Write<Fixtures, Single, Full> {
    async fn execute(&self, context: &impl CommandLineContext) -> anyhow::Result<()> {
        context.execute_command(SelectFixturesCommand {
            fixtures: vec![FixtureId::from(&self.target_entity.id)],
        })?;
        context.execute_command(WriteProgrammerCommand {
            value: FixtureControlValue::Intensity(1.0),
        })?;

        Ok(())
    }
}

impl Command for Write<Fixtures, Range, Value> {
    async fn execute(&self, context: &impl CommandLineContext) -> anyhow::Result<()> {
        let ids = context.fixture_ids()?;

        context.execute_command(SelectFixturesCommand {
            fixtures: self
                .target_entity
                .evaluate_range(&ids)
                .into_iter()
                .map(|id| FixtureId::from(&id))
                .collect(),
        })?;

        context.execute_command(WriteProgrammerCommand {
            value: FixtureControlValue::Intensity(self.value.0 as f64 / 100.0),
        })?;

        Ok(())
    }
}

impl Command for Write<Fixtures, Range, Full> {
    async fn execute(&self, context: &impl CommandLineContext) -> anyhow::Result<()> {
        let ids = context.fixture_ids()?;

        context.execute_command(SelectFixturesCommand {
            fixtures: self
                .target_entity
                .evaluate_range(&ids)
                .into_iter()
                .map(|id| FixtureId::from(&id))
                .collect(),
        })?;

        context.execute_command(WriteProgrammerCommand {
            value: FixtureControlValue::Intensity(1.0),
        })?;

        Ok(())
    }
}

impl Command for Write<Fixtures, ActiveSelection, Value> {
    async fn execute(&self, context: &impl CommandLineContext) -> anyhow::Result<()> {
        context.execute_command(WriteProgrammerCommand {
            value: FixtureControlValue::Intensity(self.value.0 as f64 / 100.0),
        })
    }
}

impl Command for Write<Fixtures, ActiveSelection, Full> {
    async fn execute(&self, context: &impl CommandLineContext) -> anyhow::Result<()> {
        context.execute_command(WriteProgrammerCommand {
            value: FixtureControlValue::Intensity(1.0),
        })
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::commands::tests::assert_command;
    use test_case::test_case;

    #[test_case("@ full")]
    #[test_case("write @ full")]
    pub fn parse_write_active_selection_full(input: &str) {
        let expected = Write {
            value: Full,
            target_type: Fixtures,
            target_entity: ActiveSelection,
        };

        assert_command(input, expected);
    }

    #[test_case("1 @ 50", 50)]
    #[test_case("1 @ 100", 100)]
    pub fn parse_write(input: &str, value: u32) {
        let expected = Write {
            value: Value(value),
            target_type: Fixtures,
            target_entity: Single { id: Id::single(1) },
        };

        assert_command(input, expected);
    }

    #[test_case("1.1 @ 50", Id::new([1, 1]), 50)]
    #[test_case("2.3 @ 100", Id::new([2, 3]), 100)]
    pub fn parse_write_sub_fixture(input: &str, id: Id, value: u32) {
        let expected = Write {
            value: Value(value),
            target_type: Fixtures,
            target_entity: Single { id },
        };

        assert_command(input, expected);
    }

    #[test_case("1.1 @ full", Id::new([1, 1]))]
    #[test_case("2.3 @ full", Id::new([2, 3]))]
    pub fn parse_write_full(input: &str, id: Id) {
        let expected = Write {
            value: Full,
            target_type: Fixtures,
            target_entity: Single { id },
        };

        assert_command(input, expected);
    }
}
