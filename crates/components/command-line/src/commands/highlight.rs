use mizer_command_executor::*;
use crate::Command;
use crate::parser::*;
use crate::ast::*;

impl Command for Highlight {
    fn try_parse(&self, tokens: &Tokens) -> Option<CommandImpl> {
        if tokens.len() > 1 {
            return None;
        }
        match tokens.iter().next()? {
            Token::Action(Action::Highlight) => Some(ToggleHighlightCommand.into()),
            _ => None,
        }
    }
}
