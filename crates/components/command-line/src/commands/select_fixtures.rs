use mizer_command_executor::*;
use mizer_fixtures::FixtureId;
use crate::Command;
use crate::parser::*;
use crate::ast::*;

impl Command for Select<Fixtures, Single> {
    fn try_parse(&self, tokens: &Tokens) -> Option<CommandImpl> {
        let mut iter = tokens.iter();
        if let Some(Token::Target((Keyword::Fixture, Selection::Single(id)))) = iter.next() {
            return Some(SelectFixturesCommand {
                fixtures: vec![FixtureId::Fixture(*id as u32)]
            }.into());
        }
        let mut iter = tokens.iter();
        if let Some(Token::Action(Action::Select)) = iter.next() {
            if let Some(Token::Target((Keyword::Fixture, Selection::Single(id)))) = iter.next() {
                return Some(SelectFixturesCommand {
                    fixtures: vec![FixtureId::Fixture(*id as u32)]
                }.into());
            }
        }

        None
    }
}

impl Command for Select<Fixtures, Range> {
    fn try_parse(&self, tokens: &Tokens) -> Option<CommandImpl> {
        let mut iter = tokens.iter();
        if let Some(Token::Target((Keyword::Fixture, Selection::Range(from, to)))) = iter.next() {
            return Some(SelectFixturesCommand {
                fixtures: (*from..=*to).map(|id| FixtureId::Fixture(id as u32)).collect()
            }.into());
        }
        let mut iter = tokens.iter();
        if let Some(Token::Action(Action::Select)) = iter.next() {
            if let Some(Token::Target((Keyword::Fixture, Selection::Range(from, to)))) = iter.next() {
                return Some(SelectFixturesCommand {
                    fixtures: (*from..=*to).map(|id| FixtureId::Fixture(id as u32)).collect()
                }.into());
            }
        }

        None
    }
}
