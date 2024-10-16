use mizer_command_executor::*;
use crate::Command;
use crate::parser::*;
use crate::ast::*;

impl Command for Delete<Sequences, Single> {
    fn try_parse(&self, tokens: &Tokens) -> Option<CommandImpl> {
        let mut iter = tokens.iter();
        if let Some(Token::Action(Action::Delete)) = iter.next() {
            if let Some(Token::Target((Keyword::Sequence, Selection::Single(id)))) = iter.next() {
                return Some(DeleteSequenceCommand {
                    sequence_id: *id as u32,
                }.into());
            }
        }

        None
    }
}
