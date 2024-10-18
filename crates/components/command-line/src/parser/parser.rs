use chumsky::prelude::*;
use super::*;

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
        "clear" => Ok(Action::Clear),
        "call" => Ok(Action::Call),
        "go" => Ok(Action::GoForward),
        "go+" => Ok(Action::GoForward),
        "go-" => Ok(Action::GoBackward),
        _ => Err(Rich::custom(span, "Unknown action")),
    })
        .map(Token::Action);

    let keyword = text::ascii::ident().try_map(|ident: &str, span: Span| match ident {
        "fixtures" => Ok(Keyword::Fixture),
        "fixture" => Ok(Keyword::Fixture),
        "sequences" => Ok(Keyword::Sequence),
        "sequence" => Ok(Keyword::Sequence),
        "seq" => Ok(Keyword::Sequence),
        "groups" => Ok(Keyword::Group),
        "group" => Ok(Keyword::Group),
        _ => Err(Rich::custom(span, "Unknown keyword")),
    }).padded();

    let selection = choice((
        text::int(10).from_str().unwrapped().padded()
            .then_ignore(choice((just("thru"), just(".."))))
            .then(text::int(10).from_str().unwrapped().padded())
            .map(|(start, end)| Selection::Range(start, end)),
        text::int(10).from_str().unwrapped().map(Selection::Single),
    )).padded();

    let target = keyword.then(selection)
        .map(|(keyword, selection)| Token::Target((keyword, selection)));
    
    let selection = selection.map(Token::Selection);

    let token = choice((selection, num, operator, action, target));

    token
        .padded()
        .repeated()
        .collect()
        .map(Tokens)
}
