use darling::{ast, util, FromDeriveInput, FromField, FromMeta};

#[derive(Debug, FromField)]
#[darling(attributes(setting), forward_attrs(allow, doc, cfg, serde))]
pub struct SettingField {
    pub ident: Option<syn::Ident>,
    pub ty: syn::Type,
    #[darling(with = |m| Ok(String::from_meta(m)?), map = Some)]
    pub category: Option<String>,
    #[darling(with = darling::util::parse_expr::preserve_str_literal, map = Some)]
    pub label: Option<syn::Expr>,
    pub min: Option<f64>,
    pub min_hint: Option<f64>,
    pub max: Option<f64>,
    pub max_hint: Option<f64>,
    pub attrs: Vec<syn::Attribute>,
}

#[derive(Debug, FromDeriveInput)]
#[darling(attributes(setting))]
pub struct Node {
    pub ident: syn::Ident,
    pub data: ast::Data<util::Ignored, SettingField>,
}
