use mizer_command_executor::*;
use mizer_fixtures::GroupId;
use crate::Command;
use crate::parser::*;
use crate::ast::*;

impl Command for Store<Fixtures, ActiveSelection, Groups, Single> {
    fn try_parse(&self, tokens: &Tokens) -> Option<CommandImpl> {
        let mut iter = tokens.iter();
        if let Some(Token::Action(Action::Store)) = iter.next() {
            if let Some(Token::Target((Keyword::Group, Selection::Single(group_id)))) = iter.next() {
                return Some(AssignProgrammerToGroupCommand {
                    group_id: GroupId::from(*group_id as u32),
                    mode: StoreGroupMode::Merge,
                }.into());
            }
        }

        None
    }
}
