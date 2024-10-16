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

impl Tokens {
    pub fn iter(&self) -> impl Iterator<Item = &Token> {
        self.0.iter()
    }

    pub fn len(&self) -> usize {
        self.0.len()
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
    Clear,
    Call,
    GoForward,
    GoBackward,
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
            Token::Number(expected),
        ]));
    }

    #[test_case("select fixtures 1", 1)]
    #[test_case("select fixtures 3", 3)]
    fn parse_fixture_selection(input: &str, expected: i64) {
        let ast = parse(input).unwrap();

        assert_eq!(ast, Tokens(vec![
            Token::Action(Action::Select),
            Token::Target((Keyword::Fixture, Selection::Single(expected))),
        ]));
    }

    #[test_case("select fixtures 1..3", 1, 3)]
    #[test_case("select fixtures 2 .. 4", 2, 4)]
    #[test_case("select fixtures 3 thru 5", 3, 5)]
    fn parse_multiple_fixture_selection(input: &str, from: i64, to: i64) {
        let ast = parse(input).unwrap();

        assert_eq!(ast, Tokens(vec![
            Token::Action(Action::Select),
            Token::Target((Keyword::Fixture, Selection::Range(from, to))),
        ]));
    }

    #[test_case("delete sequence 1", 1)]
    fn parse_delete_sequence(input: &str, expected: i64) {
        let ast = parse(input).unwrap();

        assert_eq!(ast, Tokens(vec![
            Token::Action(Action::Delete),
            Token::Target((Keyword::Sequence, Selection::Single(expected))),
        ]));
    }
}
