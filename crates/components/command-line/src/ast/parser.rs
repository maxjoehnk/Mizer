use crate::{BoxCommand, CommandLineContext};
use crate::parser::*;
use crate::ast;

pub fn parse<TContext: CommandLineContext>(tokens: Tokens) -> anyhow::Result<Box<dyn BoxCommand<TContext>>> {
    let mut iter = tokens.into_iter();
    
    match iter.next() {
        Some(Token::Selection(Selection::Single(id))) => {
            Ok(ast::Select {
                target_type: ast::Fixtures,
                target_entity: ast::Single { id: id as u32 },
            }.boxed())
        }
        Some(Token::Selection(Selection::Range(from, to))) => {
            Ok(ast::Select {
                target_type: ast::Fixtures,
                target_entity: ast::Range {
                    from: from as u32,
                    to: to as u32,
                },
            }.boxed())
        }
        Some(Token::Action(Action::Select)) => {
            match iter.next() {
                //Some(Token::Target((Keyword::Group, Selection::Single(id)))) => {
                //    Ok(ast::Select {
                //        target_type: ast::Groups,
                //        target_entity: ast::Single { id: id as u32 },
                //    }.boxed())
                //}
                //Some(Token::Target((Keyword::Sequence, Selection::Single(id)))) => {
                //    Ok(ast::Select {
                //        target_type: ast::Sequences,
                //        target_entity: ast::Single { id: id as u32 },
                //    }.boxed())
                //}
                Some(Token::Target((Keyword::Fixture, Selection::Single(id)))) => {
                    Ok(ast::Select {
                        target_type: ast::Fixtures,
                        target_entity: ast::Single { id: id as u32 },
                    }.boxed())
                }
                Some(Token::Target((Keyword::Fixture, Selection::Range(from, to)))) => {
                    Ok(ast::Select {
                        target_type: ast::Fixtures,
                        target_entity: ast::Range {
                            from: from as u32,
                            to: to as u32,
                        },
                    }.boxed())
                }
                _ => Err(anyhow::anyhow!("Invalid token"))
            }
        }
        Some(Token::Action(Action::Call)) => {
            match iter.next() {
                Some(Token::Target((Keyword::Group, Selection::Single(id)))) => {
                    Ok(ast::Call {
                        target_type: ast::Groups,
                        target_entity: ast::Single { id: id as u32 },
                    }.boxed())
                }
                // Some(Token::Target((Keyword::Sequence, Selection::Single(id)))) => {
                //     Ok(ast::Call {
                //         target_type: ast::Sequences,
                //         target_entity: ast::Single { id: id as u32 },
                //     }.boxed())
                // }
                _ => Err(anyhow::anyhow!("Invalid token"))
            }
        }
        Some(Token::Action(Action::Delete)) => {
            match iter.next() {
                Some(Token::Target((Keyword::Group, Selection::Single(id)))) => {
                    Ok(ast::Delete {
                        target_type: ast::Groups,
                        target_entity: ast::Single { id: id as u32 },
                    }.boxed())
                }
                Some(Token::Target((Keyword::Sequence, Selection::Single(id)))) => {
                    Ok(ast::Delete {
                        target_type: ast::Sequences,
                        target_entity: ast::Single { id: id as u32 },
                    }.boxed())
                }
                _ => Err(anyhow::anyhow!("Invalid token"))
            }
        }
        Some(Token::Action(Action::Off)) => {
            match iter.next() {
                Some(Token::Target((Keyword::Sequence, Selection::Single(id)))) => {
                    Ok(ast::Off {
                        target_type: ast::Sequences,
                        target_entity: ast::Single { id: id as u32 },
                    }.boxed())
                }
                _ => Err(anyhow::anyhow!("Invalid token"))
            }
        }
        Some(Token::Action(Action::GoForward)) => {
            match iter.next() {
                Some(Token::Target((Keyword::Sequence, Selection::Single(id)))) => {
                    Ok(ast::GoForward {
                        target_type: ast::Sequences,
                        target_entity: ast::Single { id: id as u32 },
                    }.boxed())
                }
                _ => Err(anyhow::anyhow!("Invalid token"))
            }
        }
        Some(Token::Action(Action::GoBackward)) => {
            match iter.next() {
                Some(Token::Target((Keyword::Sequence, Selection::Single(id)))) => {
                    Ok(ast::GoBackward {
                        target_type: ast::Sequences,
                        target_entity: ast::Single { id: id as u32 },
                    }.boxed())
                }
                _ => Err(anyhow::anyhow!("Invalid token"))
            }
        }
        Some(Token::Action(Action::Highlight)) => Ok(ast::Highlight.boxed()),
        Some(Token::Action(Action::Clear)) => Ok(ast::Clear.boxed()),
        _ => Err(anyhow::anyhow!("Invalid token"))
    }
}