use mizer_command_executor::*;
use crate::{Command, CommandLineContext};
use crate::ast::*;

impl Command for Write<Fixtures, Single, Value> {
    async fn execute(&self, context: &impl CommandLineContext) -> anyhow::Result<()> {
        todo!()
    }
}

impl Command for Write<Fixtures, Range, Value> {
    async fn execute(&self, context: &impl CommandLineContext) -> anyhow::Result<()> {
        todo!()
    }
}

impl Command for Write<Fixtures, Range, Full> {
    async fn execute(&self, context: &impl CommandLineContext) -> anyhow::Result<()> {
        todo!()
    }
}

impl Command for Write<Fixtures, ActiveSelection, Value> {
    async fn execute(&self, context: &impl CommandLineContext) -> anyhow::Result<()> {
        todo!()
    }
}

impl Command for Write<Fixtures, ActiveSelection, Full> {
    async fn execute(&self, context: &impl CommandLineContext) -> anyhow::Result<()> {
        todo!()
    }
}

#[cfg(test)]
mod tests {
    use test_case::test_case;
    use super::*;
    use crate::commands::tests::assert_command;

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
}
