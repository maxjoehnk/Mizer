use derive_more::From;
use std::collections::HashMap;

#[derive(Debug, Clone, PartialEq, From)]
pub enum Ast {
    Literal(Literal),
    PropertyAccess(PropertyAccess),
    Object(Object),
    Array(Array),
    Conditional(Conditional),
}

#[derive(Debug, Clone, PartialEq)]
pub enum Literal {
    Boolean(bool),
    Int(i64),
    Float(f64),
    String(String),
}

#[derive(Debug, Clone, PartialEq)]
pub struct PropertyAccess {
    pub path: String,
}

#[derive(Default, Debug, Clone, PartialEq)]
pub struct Object {
    pub children: HashMap<String, Ast>,
}

#[derive(Default, Debug, Clone, PartialEq)]
pub struct Array {
    pub children: Vec<Ast>,
}

#[derive(Debug, Clone, PartialEq)]
pub struct Conditional {
    pub lhs: Box<Ast>,
    pub rhs: Box<Ast>,
    pub op: Operator,
    pub success: Box<Ast>,
    pub failure: Box<Ast>,
}

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum Operator {
    Equal,
    NotEqual,
    Less,
    LessOrEqual,
    Greater,
    GreaterOrEqual,
}
