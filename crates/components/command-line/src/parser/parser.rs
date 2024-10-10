use chumsky::prelude::*;
use crate::parser::{parse, Action, Tokens, Keyword, Operator, Selection, Token};

type Span = SimpleSpan<usize>;

pub fn lexer<'src>() -> impl Parser<'src, &'src str, Tokens, extra::Err<Rich<'src, char, Span>>> {
    let num = text::int(10)
        .from_str()
        .unwrapped()
        .map(Token::Number);

    let operator = choice((
        just("@").to(Operator::At),
        just("at").to(Operator::At),
        just("+").to(Operator::Plus),
        just("-").to(Operator::Minus),
        just("*").to(Operator::Times),
        just("/").to(Operator::DividedBy)
    ))
        .map(Token::Operator);

    let action = text::ascii::ident().try_map(|ident: &str, span: Span| match ident {
        "highlight" => Ok(Action::Highlight),
        "select" => Ok(Action::Select),
        "store" => Ok(Action::Store),
        "delete" => Ok(Action::Delete),
        "off" => Ok(Action::Off),
        _ => Err(Rich::custom(span, "Unknown action")),
    })
        .map(Token::Action);

    let keyword = text::ascii::ident().try_map(|ident: &str, span: Span| match ident {
        "fixtures" => Ok(Keyword::Fixture),
        "fixture" => Ok(Keyword::Fixture),
        "sequences" => Ok(Keyword::Sequence),
        "sequence" => Ok(Keyword::Sequence),
        "groups" => Ok(Keyword::Group),
        "group" => Ok(Keyword::Group),
        _ => Err(Rich::custom(span, "Unknown keyword")),
    }).padded();

    let selection = choice((
        text::int(10).from_str().unwrapped().map(Selection::Single),
        text::int(10).from_str().unwrapped()
            .then(choice((just("thru"), just("..")))).then(text::int(10).from_str().unwrapped()).map(|((start, _), end)| Selection::Range(start, end)),
    )).padded();

    let target = keyword.then(selection)
        .map(|(keyword, selection)| Token::Target((keyword, selection)));

    let token = choice((num, operator, action, target));

    token
        .padded()
        .repeated()
        .collect()
        .map(Tokens)
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

    #[test_case("delete sequence 1", 1)]
    fn parse_delete_sequence(input: &str, expected: i64) {
        let ast = parse(input).unwrap();

        assert_eq!(ast, Tokens(vec![
            Token::Action(Action::Delete),
            Token::Target((Keyword::Sequence, Selection::Single(expected))),
        ]));
    }
}
