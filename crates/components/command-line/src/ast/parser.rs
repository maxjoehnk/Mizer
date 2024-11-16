use crate::ast;
use crate::parser::*;
use crate::{BoxCommand, CommandLineContext, Id};

pub fn parse<TContext: CommandLineContext>(
    tokens: Tokens,
) -> anyhow::Result<Box<dyn BoxCommand<TContext>>> {
    match tokens.slice() {
        &[Token::Value(ref value)] => Ok(ast::Select {
            target_type: ast::Fixtures,
            target_entity: ast::Single { id: value.as_id()? },
        }
        .boxed()),
        &[Token::Range(ref from, ref to)] => Ok(ast::Select {
            target_type: ast::Fixtures,
            target_entity: ast::Range {
                from: from.as_id()?,
                to: to.as_id()?,
            },
        }
        .boxed()),
        &[Token::Action(Action::Select), Token::Value(ref value)] => Ok(ast::Select {
            target_type: ast::Fixtures,
            target_entity: ast::Single { id: value.as_id()? },
        }
        .boxed()),
        &[Token::Action(Action::Select), Token::Keyword(Keyword::Fixture), Token::Value(ref value)] => {
            Ok(ast::Select {
                target_type: ast::Fixtures,
                target_entity: ast::Single { id: value.as_id()? },
            }
            .boxed())
        }
        &[Token::Action(Action::Call), Token::Keyword(Keyword::Group), Token::Value(ref value)] => {
            Ok(ast::Call {
                target_type: ast::Groups,
                target_entity: ast::Single { id: value.as_id()? },
            }
            .boxed())
        }
        &[Token::Action(Action::Delete), Token::Keyword(Keyword::Group), Token::Value(ref value)] => {
            Ok(ast::Delete {
                target_type: ast::Groups,
                target_entity: ast::Single { id: value.as_id()? },
            }
            .boxed())
        }
        &[Token::Action(Action::Delete), Token::Keyword(Keyword::Sequence), Token::Value(ref value)] => {
            Ok(ast::Delete {
                target_type: ast::Sequences,
                target_entity: ast::Single { id: value.as_id()? },
            }
            .boxed())
        }
        &[Token::Action(Action::Off), Token::Keyword(Keyword::Sequence), Token::Value(ref value)] => {
            Ok(ast::Off {
                target_type: ast::Sequences,
                target_entity: ast::Single { id: value.as_id()? },
            }
            .boxed())
        }
        &[Token::Action(Action::GoForward), Token::Keyword(Keyword::Sequence), Token::Value(ref value)] => {
            Ok(ast::GoForward {
                target_type: ast::Sequences,
                target_entity: ast::Single { id: value.as_id()? },
            }
            .boxed())
        }
        &[Token::Action(Action::GoBackward), Token::Keyword(Keyword::Sequence), Token::Value(ref value)] => {
            Ok(ast::GoBackward {
                target_type: ast::Sequences,
                target_entity: ast::Single { id: value.as_id()? },
            }
            .boxed())
        }
        &[Token::Action(Action::Store), Token::Keyword(Keyword::Group), Token::Value(ref value)] => {
            Ok(ast::Store {
                source_type: ast::Fixtures,
                source_entity: ast::ActiveSelection,
                target_type: ast::Groups,
                target_entity: ast::Single { id: value.as_id()? },
            }
            .boxed())
        }
        &[Token::Operator(Operator::At), Token::Full] => Ok(ast::Write {
            target_type: ast::Fixtures,
            target_entity: ast::ActiveSelection,
            value: ast::Full,
        }
        .boxed()),
        &[Token::Action(Action::Write), Token::Operator(Operator::At), Token::Full] => {
            Ok(ast::Write {
                target_type: ast::Fixtures,
                target_entity: ast::ActiveSelection,
                value: ast::Full,
            }
            .boxed())
        }
        &[Token::Operator(Operator::At), Token::Value(ValueToken::Number(value))] => {
            Ok(ast::Write {
                target_type: ast::Fixtures,
                target_entity: ast::ActiveSelection,
                value: ast::Value(value as u32),
            }
            .boxed())
        }
        &[Token::Value(ref id), Token::Operator(Operator::At), Token::Value(ValueToken::Number(value))] => {
            Ok(ast::Write {
                target_type: ast::Fixtures,
                target_entity: ast::Single { id: id.as_id()? },
                value: ast::Value(value as u32),
            }
            .boxed())
        }
        &[Token::Action(Action::Highlight)] => Ok(ast::Highlight.boxed()),
        &[Token::Action(Action::Clear)] => Ok(ast::Clear.boxed()),
        _ => Err(anyhow::anyhow!("Invalid token")),
    }
}

impl ValueToken {
    pub fn as_id(&self) -> anyhow::Result<Id> {
        match self {
            ValueToken::Number(id) => Ok(Id::single(*id as u32)),
            ValueToken::NumericPath(path) => {
                if path.len() == 2 {
                    Ok(Id::new([path[0] as u32, path[1] as u32]))
                } else {
                    Err(anyhow::anyhow!("Invalid path length"))
                }
            }
        }
    }
}
