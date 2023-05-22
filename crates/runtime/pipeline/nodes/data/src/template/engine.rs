use crate::template::ast::*;
use crate::template::parser::parse;
use mizer_util::StructuredData;
use std::collections::HashMap;

pub struct TemplateEngine;

impl TemplateEngine {
    pub fn template(
        &self,
        template: &str,
        values: Vec<StructuredData>,
    ) -> anyhow::Result<StructuredData> {
        let ast = parse(template)?;
        let values = StructuredData::Array(values);
        let mut map = HashMap::new();
        map.insert("values".to_string(), values);
        let values = StructuredData::Object(map);

        Self::execute_ast(ast, &values)
    }

    fn execute_ast(ast: Ast, values: &StructuredData) -> anyhow::Result<StructuredData> {
        let result = match ast {
            Ast::Literal(Literal::Boolean(bool)) => StructuredData::Boolean(bool),
            Ast::Literal(Literal::Int(int)) => StructuredData::Int(int),
            Ast::Literal(Literal::Float(float)) => StructuredData::Float(float),
            Ast::Literal(Literal::String(text)) => StructuredData::Text(text),
            Ast::PropertyAccess(PropertyAccess { path }) => values
                .access(&path)
                .ok_or_else(|| anyhow::anyhow!("Invalid property access: {path}"))?
                .clone(),
            Ast::Object(object) => {
                let mut children = HashMap::new();
                for (key, child) in object.children {
                    children.insert(key, Self::execute_ast(child, values)?);
                }

                StructuredData::Object(children)
            }
            Ast::Array(array) => {
                let data = array
                    .children
                    .into_iter()
                    .map(|child| Self::execute_ast(child, values))
                    .collect::<Result<Vec<_>, _>>()?;

                StructuredData::Array(data)
            }
            Ast::Conditional(conditional) => {
                let lhs = Self::execute_ast(*conditional.lhs, values)?;
                let rhs = Self::execute_ast(*conditional.rhs, values)?;
                if conditional.op.evaluate(lhs, rhs, values) {
                    Self::execute_ast(*conditional.success, values)?
                } else {
                    Self::execute_ast(*conditional.failure, values)?
                }
            }
        };

        Ok(result)
    }
}

impl Operator {
    fn evaluate(&self, lhs: StructuredData, rhs: StructuredData, _values: &StructuredData) -> bool {
        use StructuredData::*;

        match (self, lhs, rhs) {
            (Operator::Equal, lhs, rhs) => lhs == rhs,
            (Operator::NotEqual, lhs, rhs) => lhs != rhs,
            (Operator::Greater, Int(lhs), Int(rhs)) => lhs > rhs,
            (Operator::GreaterOrEqual, Int(lhs), Int(rhs)) => lhs >= rhs,
            (Operator::Less, Int(lhs), Int(rhs)) => lhs < rhs,
            (Operator::LessOrEqual, Int(lhs), Int(rhs)) => lhs <= rhs,
            (Operator::Greater, Float(lhs), Float(rhs)) => lhs > rhs,
            (Operator::GreaterOrEqual, Float(lhs), Float(rhs)) => lhs >= rhs,
            (Operator::Less, Float(lhs), Float(rhs)) => lhs < rhs,
            (Operator::LessOrEqual, Float(lhs), Float(rhs)) => lhs <= rhs,
            _ => false,
        }
    }
}

#[cfg(test)]
mod tests {
    use super::TemplateEngine;
    use mizer_util::StructuredData;
    use std::collections::HashMap;
    use test_case::test_case;

    #[test_case("true", StructuredData::Boolean(true))]
    #[test_case("false", StructuredData::Boolean(false))]
    #[test_case("1.0", StructuredData::Float(1.0))]
    #[test_case("50.123", StructuredData::Float(50.123))]
    #[test_case("-3.4", StructuredData::Float(-3.4))]
    #[test_case("0", StructuredData::Int(0))]
    #[test_case("10", StructuredData::Int(10))]
    #[test_case("-2", StructuredData::Int(-2))]
    #[test_case(r#""test""#, StructuredData::Text("test".to_string()))]
    #[test_case(r#""""#, StructuredData::Text("".to_string()))]
    fn basic_value_template(template: &str, expected: StructuredData) {
        let result = TemplateEngine.template(template, vec![]);

        assert_eq!(expected, result.unwrap());
    }

    #[test_case(StructuredData::Boolean(true))]
    #[test_case(StructuredData::Int(0))]
    fn access_supplied_values(data: StructuredData) {
        let result = TemplateEngine.template("values.0", vec![data.clone()]);

        assert_eq!(data, result.unwrap());
    }

    #[test]
    fn build_object() {
        let mut map = HashMap::new();
        map.insert("red".into(), StructuredData::Int(255));
        map.insert("green".into(), StructuredData::Int(128));
        map.insert("blue".into(), StructuredData::Int(0));
        let expected = StructuredData::Object(map);
        let template = r#"
        {
            red: 255,
            green: 128,
            blue: 0,
        }
        "#;

        let result = TemplateEngine.template(template, vec![]).unwrap();

        assert_eq!(result, expected);
    }

    #[test_case(255, 128, 0)]
    #[test_case(128, 0, 255)]
    fn build_object_with_properties(red: i64, green: i64, blue: i64) {
        let data = vec![
            StructuredData::Int(red),
            StructuredData::Int(green),
            StructuredData::Int(blue),
        ];
        let mut map = HashMap::new();
        map.insert("red".into(), StructuredData::Int(red));
        map.insert("green".into(), StructuredData::Int(green));
        map.insert("blue".into(), StructuredData::Int(blue));
        let expected = StructuredData::Object(map);
        let template = r#"
        {
            red: values.0,
            green: values.1,
            blue: values.2,
        }
        "#;

        let result = TemplateEngine.template(template, data).unwrap();

        assert_eq!(result, expected);
    }

    #[test]
    fn build_array() {
        let expected = StructuredData::Array(vec![
            StructuredData::Int(255),
            StructuredData::Int(128),
            StructuredData::Int(0),
        ]);
        let template = r#"
        [
            255,
            128,
            0,
        ]
        "#;

        let result = TemplateEngine.template(template, vec![]).unwrap();

        assert_eq!(result, expected);
    }

    #[test_case(255, 128, 0)]
    #[test_case(128, 0, 255)]
    fn build_array_with_properties(red: i64, green: i64, blue: i64) {
        let data = vec![
            StructuredData::Int(red),
            StructuredData::Int(green),
            StructuredData::Int(blue),
        ];
        let expected = StructuredData::Array(data.clone());
        let template = r#"
        [
            values.0,
            values.1,
            values.2,
        ]
        "#;

        let result = TemplateEngine.template(template, data).unwrap();

        assert_eq!(result, expected);
    }

    #[test_case(255, 128, 0)]
    #[test_case(128, 0, 255)]
    fn directly_return_data_array(red: i64, green: i64, blue: i64) {
        let data = vec![
            StructuredData::Int(red),
            StructuredData::Int(green),
            StructuredData::Int(blue),
        ];
        let expected = StructuredData::Array(data.clone());
        let template = r#"
        values
        "#;

        let result = TemplateEngine.template(template, data).unwrap();

        assert_eq!(result, expected);
    }

    #[test_case("true == true ? true : false", StructuredData::Boolean(true); "equals")]
    #[test_case("true != true ? true : false", StructuredData::Boolean(false); "not equals")]
    #[test_case("1 > 0 ? 2 : -2", StructuredData::Int(2); "greater")]
    #[test_case("1 < 0 ? 2 : -2", StructuredData::Int(-2); "less")]
    #[test_case(r#"1.0 >= 0.0 ? "yes" : "no""#, StructuredData::Text("yes".to_string()); "greater equals")]
    #[test_case(r#"1.0 <= 0.0 ? "big" : "small""#, StructuredData::Text("small".to_string()); "less equals")]
    fn evaluate_conditional(template: &str, expected: StructuredData) {
        let result = TemplateEngine.template(template, vec![]).unwrap();

        assert_eq!(result, expected);
    }
}
