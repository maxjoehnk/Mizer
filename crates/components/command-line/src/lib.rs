use mizer_command_executor::CommandImpl;
use std::sync::LazyLock;
use crate::parser::Tokens;

mod ast;
mod parser;
mod commands;

static COMMANDS: LazyLock<Vec<Box<dyn Command>>> = LazyLock::new(|| vec![
    ast::Highlight::new(),
    ast::Delete::<ast::Sequences, ast::Single>::new(),
    // ast::Delete::<ast::Sequences, ast::Range>::new(),
    ast::Delete::<ast::Groups, ast::Single>::new(),
    ast::Select::<ast::Fixtures, ast::Single>::new(),
    ast::Select::<ast::Fixtures, ast::Range>::new(),
    ast::Clear::new(),
    ast::Store::<ast::Fixtures, ast::ActiveSelection, ast::Groups, ast::Single>::new(),
    // ast::Store::<ast::Fixtures, ast::ActiveSelection, ast::Sequences, ast::Single>::new(),
    ast::Call::<ast::Groups, ast::Single>::new(),
]);

trait Command: Send + Sync {
    fn try_parse(&self, tokens: &Tokens) -> Option<CommandImpl>;
}

pub fn try_parse_as_command(input: &str) -> anyhow::Result<CommandImpl> {
    let tokens = parser::parse(input)?;

    let command = COMMANDS.iter().find_map(|command| command.try_parse(&tokens))
        .ok_or_else(|| anyhow::anyhow!("Invalid command"))?;
    
    Ok(command)
}

