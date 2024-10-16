use mizer_command_executor::*;
use mizer_fixtures::GroupId;
use crate::Command;
use crate::parser::*;
use crate::ast::*;

impl Command for Delete<Groups, Single> {
    fn try_parse(&self, tokens: &Tokens) -> Option<CommandImpl> {
        let mut iter = tokens.iter();
        if let Some(Token::Action(Action::Delete)) = iter.next() {
            if let Some(Token::Target((Keyword::Group, Selection::Single(id)))) = iter.next() {
                return Some(DeleteGroupCommand {
                    id: GroupId::from(*id as u32),
                }.into());
            }
        }

        None
    }
}
