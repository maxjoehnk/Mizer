use crate::parser::*;
use mizer_fixtures::FixtureId;

pub enum Ast {
    Delete(Target),
    Select(Target),
    Store(Target),
    Highlight,
}

pub enum Target {
    Fixture(FixtureTarget),
    Sequence(u32),
    Group(u32),
}

pub fn parse(tokens: Tokens) -> anyhow::Result<Ast> {
    let mut tokens = tokens.into_iter();
    let token = tokens.next().unwrap();
    match token {
        Token::Action(Action::Delete) => {
            let target = match tokens.next().unwrap() {
                Token::Target((Keyword::Sequence, Selection::Single(id))) => Target::Sequence(id as u32),
                Token::Target((Keyword::Group, Selection::Single(id))) => Target::Group(id as u32),
                Token::Target((Keyword::Fixture, Selection::Single(id))) => Target::Fixture(FixtureTarget::Single(FixtureId::from(id as u32))),
                _ => todo!(),
            };
            Ok(Ast::Delete(target))
        }
        Token::Action(Action::Store) => {
            let target = match tokens.next().unwrap() {
                Token::Target((Keyword::Sequence, Selection::Single(id))) => Target::Sequence(id as u32),
                Token::Target((Keyword::Group, Selection::Single(id))) => Target::Group(id as u32),
                Token::Target((Keyword::Fixture, Selection::Single(id))) => Target::Fixture(FixtureTarget::Single(FixtureId::from(id as u32))),
                _ => todo!(),
            };
            Ok(Ast::Store(target))
        }
        Token::Action(Action::Select) => {
            let target = match tokens.next().unwrap() {
                Token::Target((Keyword::Fixture, Selection::Single(id))) => Target::Fixture(FixtureTarget::Single(FixtureId::from(id as u32))),
                Token::Target((Keyword::Fixture, Selection::Range(start, end))) => Target::Fixture(FixtureTarget::Range((FixtureId::from(start as u32), FixtureId::from(end as u32)))),
                _ => todo!(),
            };
            Ok(Ast::Select(target))
        }
        Token::Action(Action::Highlight) => Ok(Ast::Highlight),
        _ => todo!(),
    }
}

pub enum FixtureTarget {
    Single(FixtureId),
    Range((FixtureId, FixtureId)),
}

impl From<FixtureTarget> for Vec<FixtureId> {
    fn from(target: FixtureTarget) -> Self {
        match target {
            FixtureTarget::Single(id) => vec![id],
            FixtureTarget::Range((start, end)) => {
                // TODO: should the select command discard the unknown fixture ids or the command line executor?
                let mut ids = Vec::new();
                for id in start..=end {
                    ids.push(FixtureId::from(id));
                }

                ids
            },
        }
    }
}
