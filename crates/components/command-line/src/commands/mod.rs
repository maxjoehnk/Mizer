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
