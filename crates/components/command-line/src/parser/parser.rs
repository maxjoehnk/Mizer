use super::*;
use chumsky::prelude::*;

type Span = SimpleSpan<usize>;

pub fn lexer<'src>() -> impl Parser<'src, &'src str, Tokens, extra::Err<Rich<'src, char, Span>>> {
    let num = text::int(10).from_str().unwrapped();

    let num_path = text::int(10)
        .from_str()
        .unwrapped()
        .then_ignore(just("."))
        .then(text::int(10).from_str().unwrapped())
        .map(|(a, b)| vec![a, b]);

    let value = choice((
        num_path.map(ValueToken::NumericPath),
        num.map(ValueToken::Number),
    ));

    let operator = choice((
        just("@").to(Operator::At),
        just("at").to(Operator::At),
        just("+").to(Operator::Plus),
        just("-").to(Operator::Minus),
        just("*").to(Operator::Times),
        just("/").to(Operator::DividedBy),
    ))
    .map(Token::Operator);

    let action = text::ascii::ident().try_map(|ident: &str, span: Span| match ident {
        "highlight" => Ok(Action::Highlight),
        "select" => Ok(Action::Select),
        "write" => Ok(Action::Write),
        "store" => Ok(Action::Store),
        "delete" => Ok(Action::Delete),
        "off" => Ok(Action::Off),
        "clear" => Ok(Action::Clear),
        "call" => Ok(Action::Call),
        "go" => Ok(Action::GoForward),
        _ => Err(Rich::custom(span, "Unknown action")),
    });
    let go_forward = just("go+").to(Action::GoForward);
    let go_backward = just("go-").to(Action::GoBackward);
    let action = choice((go_forward, go_backward, action)).map(Token::Action);

    let keyword = text::ascii::ident()
        .try_map(|ident: &str, span: Span| match ident {
            "fixtures" => Ok(Keyword::Fixture),
            "fixture" => Ok(Keyword::Fixture),
            "sequences" => Ok(Keyword::Sequence),
            "sequence" => Ok(Keyword::Sequence),
            "seq" => Ok(Keyword::Sequence),
            "groups" => Ok(Keyword::Group),
            "group" => Ok(Keyword::Group),
            _ => Err(Rich::custom(span, "Unknown keyword")),
        })
        .map(Token::Keyword);

    let range = value
        .padded()
        .then_ignore(choice((just("thru"), just(".."))))
        .then(value.padded())
        .map(|(start, end)| Token::Range(start, end));

    let single = value.map(Token::Value);

    let full = just("full").to(Token::Full);
    let all = just("all").to(Token::All);

    let token = choice((range, single, operator, action, keyword, full, all));

    token.padded().repeated().collect().map(Tokens)
}
