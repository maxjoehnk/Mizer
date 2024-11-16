use std::ops::Deref;
use chumsky::Parser;
use crate::Id;

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

impl Tokens {
    pub fn iter(&self) -> impl Iterator<Item = &Token> {
        self.0.iter()
    }

    pub fn len(&self) -> usize {
        self.0.len()
    }

    pub fn slice(&self) -> &[Token] {
        &self.0
    }
}

#[derive(Debug, Clone, PartialEq)]
pub enum Token {
    Action(Action),
    Keyword(Keyword),
    Range(ValueToken, ValueToken),
    Value(ValueToken),
    Operator(Operator),
    Full,
}

#[derive(Debug, Clone, PartialEq)]
pub enum ValueToken {
    Number(i64),
    NumericPath(Vec<i64>),
}

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum Action {
    Select,
    Store,
    Delete,
    Off,
    Highlight,
    Clear,
    Call,
    GoForward,
    GoBackward,
    Write,
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

pub fn parse(input: &str) -> anyhow::Result<Tokens> {
    let lowercase = input.to_lowercase();
    let result = parser::lexer().parse(&lowercase);
    tracing::debug!("{result:?}");
    let (output, errors) = result.into_output_errors();
    let ast = output.ok_or_else(|| anyhow::anyhow!("Failed to parse: {:?}", errors))?;

    Ok(ast)
}

#[cfg(test)]
mod tests {
    use test_case::test_case;
    use super::*;

    #[test_case("@ 20", 20)]
    #[test_case("@ 100", 100)]
    #[test_case("at 20", 20)]
    fn parse_at(input: &str, expected: i64) {
        let ast = parse(input).unwrap();

        assert_eq!(ast, Tokens(vec![
            Token::Operator(Operator::At),
            Token::Value(ValueToken::Number(expected)),
        ]));
    }

    #[test]
    fn parse_at_full() {
        let ast = parse("@ full").unwrap();

        assert_eq!(ast, Tokens(vec![
            Token::Operator(Operator::At),
            Token::Full,
        ]));
    }

    #[test]
    fn parse_write_at_full() {
        let ast = parse("write @ full").unwrap();

        assert_eq!(ast, Tokens(vec![
            Token::Action(Action::Write),
            Token::Operator(Operator::At),
            Token::Full,
        ]));
    }

    #[test_case("select fixtures 1", 1)]
    #[test_case("select fixtures 3", 3)]
    fn parse_fixture_selection(input: &str, expected: u32) {
        let ast = parse(input).unwrap();

        assert_eq!(ast, Tokens(vec![
            Token::Action(Action::Select),
            Token::Keyword(Keyword::Fixture),
            Token::Value(ValueToken::Number(expected as i64)),
        ]));
    }

    #[test_case("select 1", 1)]
    #[test_case("select 3", 3)]
    fn parse_implicit_selection(input: &str, expected: u32) {
        let ast = parse(input).unwrap();

        assert_eq!(ast, Tokens(vec![
            Token::Action(Action::Select),
            Token::Value(ValueToken::Number(expected as i64)),
        ]));
    }

    #[test_case("select 1.1", vec![1, 1])]
    #[test_case("select 3.2", vec![3, 2])]
    fn parse_deep_selection(input: &str, expected: Vec<i64>) {
        let ast = parse(input).unwrap();

        assert_eq!(ast, Tokens(vec![
            Token::Action(Action::Select),
            Token::Value(ValueToken::NumericPath(expected)),
        ]));
    }

    #[test_case("select fixtures 1..3", 1, 3)]
    #[test_case("select fixtures 2 .. 4", 2, 4)]
    #[test_case("select fixtures 3 thru 5", 3, 5)]
    fn parse_multiple_fixture_selection(input: &str, from: u32, to: u32) {
        let ast = parse(input).unwrap();

        assert_eq!(ast, Tokens(vec![
            Token::Action(Action::Select),
            Token::Keyword(Keyword::Fixture),
            Token::Range(ValueToken::Number(from as i64), ValueToken::Number(to as i64)),
        ]));
    }

    #[test_case("delete sequence 1", 1)]
    fn parse_delete_sequence(input: &str, expected: u32) {
        let ast = parse(input).unwrap();

        assert_eq!(ast, Tokens(vec![
            Token::Action(Action::Delete),
            Token::Keyword(Keyword::Sequence),
            Token::Value(ValueToken::Number(expected as i64)),
        ]));
    }

    #[test_case("go"; "go")]
    #[test_case("go+"; "go plus")]
    fn parse_go_forward_sequence(input: &str) {
        let ast = parse(input).unwrap();

        assert_eq!(ast, Tokens(vec![
            Token::Action(Action::GoForward),
        ]));
    }

    #[test]
    fn parse_go_backward_sequence() {
        let ast = parse("go-").unwrap();

        assert_eq!(ast, Tokens(vec![
            Token::Action(Action::GoBackward),
        ]));
    }
}
