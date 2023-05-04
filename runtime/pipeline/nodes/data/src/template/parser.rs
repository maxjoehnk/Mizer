use nom::branch::alt;
use nom::bytes::complete::{tag, take_until};
use nom::character::complete::{alpha1, alphanumeric0, char, digit1, i64, multispace0};
use nom::combinator::{complete, map, opt, recognize};
use nom::multi::{many0, separated_list1};
use nom::number::complete::double;
use nom::sequence::{delimited, pair, separated_pair, tuple};
use nom::{IResult, Parser};

use super::ast::*;

pub fn parse(input: &str) -> anyhow::Result<Ast> {
    let (_, ast) = complete(delimited(multispace0, parse_ast, multispace0))(input)
        .map_err(|err| anyhow::anyhow!("Unable to parse template: {err:?}"))?;

    Ok(ast)
}

fn parse_ast(input: &str) -> IResult<&str, Ast> {
    alt((
        map(parse_conditional, Ast::Conditional),
        parse_expressions,
        map(parse_object, Ast::Object),
        map(parse_array, Ast::Array),
    ))(input)
}

fn parse_expressions(input: &str) -> IResult<&str, Ast> {
    alt((
        map(parse_literal, Ast::Literal),
        map(parse_property_access, Ast::PropertyAccess),
    ))(input)
}

fn parse_literal(input: &str) -> IResult<&str, Literal> {
    alt((
        map(tag("true"), |_| Literal::Boolean(true)),
        map(tag("false"), |_| Literal::Boolean(false)),
        parse_float,
        parse_int,
        parse_string,
    ))(input)
}

fn parse_property_access(input: &str) -> IResult<&str, PropertyAccess> {
    map(
        separated_list1(char('.'), alt((digit1, parse_identifier))),
        |parts| {
            let path = parts.join(".");

            PropertyAccess { path }
        },
    )(input)
}

fn parse_identifier(input: &str) -> IResult<&str, &str> {
    map(pair(alpha1, alphanumeric0), |(lhs, _)| lhs)(input)
}

fn parse_float(input: &str) -> IResult<&str, Literal> {
    map(
        recognize(pair(
            opt(char('-')),
            separated_pair(digit1, char('.'), digit1),
        ))
        .and_then(double),
        Literal::Float,
    )(input)
}

fn parse_int(input: &str) -> IResult<&str, Literal> {
    map(i64, Literal::Int)(input)
}

fn parse_string(input: &str) -> IResult<&str, Literal> {
    map(
        delimited(char('"'), take_until("\""), char('"')),
        |text: &str| Literal::String(text.to_string()),
    )(input)
}

fn parse_object(input: &str) -> IResult<&str, Object> {
    map(
        delimited(
            char('{'),
            many0(map(
                tuple((
                    multispace0,
                    parse_identifier,
                    multispace0,
                    char(':'),
                    multispace0,
                    parse_ast,
                    char(','),
                    multispace0,
                )),
                |(_, identifier, _, _, _, ast, _, _)| (identifier.to_string(), ast),
            )),
            char('}'),
        ),
        |properties| {
            let children = properties.into_iter().collect();

            Object { children }
        },
    )(input)
}

fn parse_array(input: &str) -> IResult<&str, Array> {
    map(
        delimited(
            char('['),
            many0(map(
                tuple((multispace0, parse_ast, char(','), multispace0)),
                |(_, ast, _, _)| ast,
            )),
            char(']'),
        ),
        |children| Array { children },
    )(input)
}

fn parse_conditional(input: &str) -> IResult<&str, Conditional> {
    map(
        tuple((
            multispace0,
            parse_expressions,
            multispace0,
            parse_op,
            multispace0,
            parse_expressions,
            multispace0,
            char('?'),
            multispace0,
            parse_expressions,
            multispace0,
            char(':'),
            multispace0,
            parse_expressions,
            multispace0,
        )),
        |(_, lhs, _, op, _, rhs, _, _, _, success, _, _, _, failure, _)| Conditional {
            lhs: Box::new(lhs),
            op,
            rhs: Box::new(rhs),
            success: Box::new(success),
            failure: Box::new(failure),
        },
    )(input)
}

fn parse_op(input: &str) -> IResult<&str, Operator> {
    alt((
        map(tag("=="), |_| Operator::Equal),
        map(tag("!="), |_| Operator::NotEqual),
        map(tag(">="), |_| Operator::GreaterOrEqual),
        map(tag("<="), |_| Operator::LessOrEqual),
        map(tag(">"), |_| Operator::Greater),
        map(tag("<"), |_| Operator::Less),
    ))(input)
}

#[cfg(test)]
mod tests {
    use std::collections::HashMap;
    use test_case::test_case;

    use crate::template::ast::*;

    use super::parse;

    #[test_case("true", Literal::Boolean(true))]
    #[test_case("false", Literal::Boolean(false))]
    #[test_case("1.0", Literal::Float(1.0))]
    #[test_case("50.123", Literal::Float(50.123))]
    #[test_case("-3.4", Literal::Float(-3.4))]
    #[test_case("0", Literal::Int(0))]
    #[test_case("10", Literal::Int(10))]
    #[test_case("-2", Literal::Int(-2))]
    #[test_case(r#""test""#, Literal::String("test".to_string()))]
    #[test_case(r#""""#, Literal::String("".to_string()))]
    fn parse_literal(input: &str, literal: Literal) {
        let expected = Ast::Literal(literal);

        let result = parse(input).unwrap();

        assert_eq!(expected, result);
    }

    #[test_case(" true ", Literal::Boolean(true))]
    #[test_case(" 1.0 ", Literal::Float(1.0))]
    #[test_case(" -1 ", Literal::Int(-1))]
    #[test_case(r#" "test" "#, Literal::String("test".to_string()))]
    fn parse_literal_with_whitespace(input: &str, literal: Literal) {
        let expected = Ast::Literal(literal);

        let result = parse(input).unwrap();

        assert_eq!(expected, result);
    }

    #[test_case("values.0")]
    #[test_case("values.1.name")]
    fn parse_property_path(input: &str) {
        let expected = PropertyAccess {
            path: input.to_string(),
        };
        let expected = Ast::PropertyAccess(expected);

        let result = parse(input).unwrap();

        assert_eq!(expected, result);
    }

    #[test]
    fn parse_empty_object() {
        let expected = Ast::Object(Default::default());

        let result = parse("{}").unwrap();

        assert_eq!(expected, result);
    }

    #[test]
    fn parse_object() {
        let mut children = HashMap::new();
        children.insert("red".into(), Ast::Literal(Literal::Int(255)));
        let expected = Object { children };
        let expected = Ast::Object(expected);
        let template = r#"{
            red: 255,
        }"#;

        let result = parse(template).unwrap();

        assert_eq!(expected, result);
    }

    #[test]
    fn parse_empty_array() {
        let expected = Ast::Array(Default::default());

        let result = parse("[]").unwrap();

        assert_eq!(expected, result);
    }

    #[test]
    fn parse_array() {
        let children = vec![Ast::Literal(Literal::Int(255))];
        let expected = Array { children };
        let expected = Ast::Array(expected);
        let template = r#"[
            255,
        ]"#;

        let result = parse(template).unwrap();

        assert_eq!(expected, result);
    }

    #[test_case("1 == 2", Literal::Int(1), Literal::Int(2), Operator::Equal)]
    #[test_case(
        "true != false",
        Literal::Boolean(true),
        Literal::Boolean(false),
        Operator::NotEqual
    )]
    #[test_case("1.0 < 2", Literal::Float(1.), Literal::Int(2), Operator::Less)]
    #[test_case("2 > 1.0", Literal::Int(2), Literal::Float(1.), Operator::Greater)]
    #[test_case("1 <= 2", Literal::Int(1), Literal::Int(2), Operator::LessOrEqual)]
    #[test_case("2 >= 1", Literal::Int(2), Literal::Int(1), Operator::GreaterOrEqual)]
    fn parse_conditional_operation(
        input: &str,
        lhs: impl Into<Ast>,
        rhs: impl Into<Ast>,
        op: Operator,
    ) {
        let expected = Conditional {
            lhs: Box::new(lhs.into()),
            rhs: Box::new(rhs.into()),
            op,
            success: Box::new(Literal::Boolean(true).into()),
            failure: Box::new(Literal::Boolean(false).into()),
        };
        let expected = Ast::Conditional(expected);
        let template = format!("{input} ? true : false");

        let result = parse(&template).unwrap();

        assert_eq!(expected, result);
    }

    #[test_case("true : false", Literal::Boolean(true), Literal::Boolean(false))]
    #[test_case("1 : 2.0", Literal::Int(1), Literal::Float(2.0))]
    #[test_case(r#""lhs" : "rhs""#, Literal::String("lhs".to_string()), Literal::String("rhs".to_string()))]
    fn parse_conditional_values(input: &str, success: impl Into<Ast>, failure: impl Into<Ast>) {
        let expected = Conditional {
            lhs: Box::new(Literal::Boolean(true).into()),
            rhs: Box::new(Literal::Boolean(false).into()),
            op: Operator::Equal,
            success: Box::new(success.into()),
            failure: Box::new(failure.into()),
        };
        let expected = Ast::Conditional(expected);
        let template = format!("true == false ? {input}");

        let result = parse(&template).unwrap();

        assert_eq!(expected, result);
    }
}
