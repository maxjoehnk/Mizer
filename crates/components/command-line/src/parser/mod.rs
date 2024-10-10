use chumsky::Parser;

mod parser;

#[derive(Debug, Clone, PartialEq)]
pub struct Tokens(Vec<Token>);

impl IntoIterator for Tokens {
    type Item = Token;
    type IntoIter = std::vec::IntoIter<Self::Item>;

    fn into_iter(self) -> Self::IntoIter {
        self.0.into_iter()
    }
}

#[derive(Debug, Clone, PartialEq)]
pub enum Token {
    Action(Action),
    Target((Keyword, Selection)),
    Number(i64),
    Operator(Operator),
    Full,
}

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum Action {
    Select,
    Store,
    Delete,
    Off,
    Highlight,
}

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum Keyword {
    Fixture,
    Sequence,
    Group,
}

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum Operator {
    At,
    Plus,
    Minus,
    Times,
    DividedBy,
}

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum Selection {
    Single(i64),
    Range(i64, i64),
}

pub fn parse(input: &str) -> anyhow::Result<Tokens> {
    let result = parser::lexer().parse(input);
    println!("{:?}", result);
    let ast = result.into_output().unwrap();

    Ok(ast)
}

