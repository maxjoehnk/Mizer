use crate::parser::*;

pub enum Ast {
    Delete(Target),
    // Select(Target),
    Store(Target),
    Highlight,
}

pub enum Target {
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
                _ => todo!(),
            };
            Ok(Ast::Delete(target))
        }
        Token::Action(Action::Store) => {
            let target = match tokens.next().unwrap() {
                Token::Target((Keyword::Sequence, Selection::Single(id))) => Target::Sequence(id as u32),
                Token::Target((Keyword::Group, Selection::Single(id))) => Target::Group(id as u32),
                _ => todo!(),
            };
            Ok(Ast::Store(target))
        }
        Token::Action(Action::Highlight) => Ok(Ast::Highlight),
        _ => todo!(),
    }
}
