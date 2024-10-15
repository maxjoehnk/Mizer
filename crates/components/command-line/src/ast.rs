use mizer_command_executor::{CommandImpl, SendableCommand};
use mizer_fixtures::definition::FixtureFaderControl;
use crate::parser::*;
use mizer_fixtures::FixtureId;

// pub enum Ast {
//     Delete(Target),
//     Select(Target),
//     Store(Target),
//     Highlight,
//     Clear,
//     Write(FixtureTarget, FixtureFaderControl, f64),
// }
// 
// pub struct Fixtures;
// pub struct Sequences;
// pub struct Groups;
// 
// pub struct ActiveSelection;
// pub struct Single(u32);
// pub struct Range(u32, u32);
// 
// pub struct Delete;
// pub struct Store;
// pub struct Select;
// pub struct Highlight;
// pub struct Clear;
// pub struct Write;
// 
// trait Executable {
//     type Source;
//     type Command;
//     type Target;
// }
// 
// impl Executable for () {
//     type Source = ();
//     type Command = Select;
//     type Target = (Fixtures, Single);
// }
// 
// struct Command<TSource, TCommand, TTarget>(TSource, TCommand, TTarget);

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
                Token::Target((Keyword::Fixture, Selection::Range(start, end))) => Target::Fixture(FixtureTarget::Range((start as u32, end as u32))),
                _ => todo!(),
            };
            Ok(Ast::Select(target))
        }
        Token::Action(Action::Highlight) => Ok(Ast::Highlight),
        Token::Action(Action::Clear) => Ok(Ast::Clear),
        Token::Operator(Operator::At) => todo!(),
        _ => todo!(),
    }
}

pub enum FixtureTarget {
    Single(FixtureId),
    Range((u32, u32)),
    Selection,
}
