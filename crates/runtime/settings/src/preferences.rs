///! A preference is a single setting from the main Setting struct.
use crate::Settings;
use facet::{Def, Field, HasFields, Peek, PrimitiveType, Type, UserType};
use heck::ToTitleCase;
use itertools::Itertools;
use std::collections::HashSet;
use std::path::PathBuf;


#[derive(Debug, Clone)]
pub struct Preference {
    pub title: String,
    pub key: String,
    pub category: String,
    pub group: Option<String>,
    pub default_value: bool,
    pub value: PreferenceValue,
}

#[derive(Debug, Clone)]
pub enum PreferenceValue {
    Select {
        selected: String,
        options: Vec<SelectOption>,
    },
    Boolean(bool),
    Path(PathBuf),
    PathList(Vec<PathBuf>),
    Hotkey(String),
}

#[derive(Debug, Clone)]
pub struct SelectOption {
    pub title: String,
    pub value: String,
}

impl Settings {
    pub(crate) fn as_preferences(
        &self,
        changed: HashSet<String>,
    ) -> Vec<Preference> {
        let mut preferences = vec![];

        let peek = Peek::new(self);
        let struct_ = peek.into_struct().expect("Settings must be a struct");

        for (field, peek) in struct_.fields() {
            let category = field.name.to_title_case();

            let category_struct = peek
                .into_struct()
                .expect("Settings category must be a struct");

            for (category_field, peek) in category_struct.fields() {
                let shape = category_field.shape.get();
                match (shape.def, shape.ty) {
                    (_, Type::User(UserType::Struct(_))) => {
                        let group = Some(category_field.name.to_title_case());

                        let group_struct = peek
                            .into_struct()
                            .expect("Shape was struct but value was not");

                        for (group_field, peek) in group_struct.fields() {
                            let path = format!(
                                "{}.{}.{}",
                                field.name, category_field.name, group_field.name
                            );
                            if let Some(value) = map_value(group_field, peek) {
                                preferences.push(Preference {
                                    title: group_field.name.to_title_case(),
                                    default_value: !changed.contains(&path),
                                    key: path,
                                    category: category.clone(),
                                    group: group.clone(),
                                    value,
                                });
                            } else {
                                tracing::warn!(
                                "Unknown type for setting @ {path}: {category_field:?} {peek:?}"
                            );
                            }
                        }
                    }
                    (_, Type::User(UserType::Opaque)) if shape.type_identifier == "HashMap" => {
                        let group = Some(category_field.name.to_title_case());

                        let map = peek
                            .into_map()
                            .expect("Shape was HashMap but value was not");

                        map.iter()
                            .filter_map(|(key, value)| {
                                let key = key.into_enum().ok()?;
                                let index = key.variant_index().ok()?;
                                let active_variant = key.active_variant().ok()?;
                                let key = active_variant.rename.unwrap_or(active_variant.name);
                                let path =
                                    format!("{}.{}.{}", field.name, category_field.name, key);
                                let value = value.get::<String>().ok()?;

                                Some((
                                    index,
                                    Preference {
                                        title: active_variant.name.to_title_case(),
                                        default_value: !changed.contains(&path),
                                        key: path,
                                        category: category.clone(),
                                        group: group.clone(),
                                        value: PreferenceValue::Hotkey(value.to_string()),
                                    },
                                ))
                            })
                            .sorted_by_key(|(index, _)| *index)
                            .for_each(|(_, setting)| preferences.push(setting));
                    }
                    _ => {
                        let path = format!("{}.{}", field.name, category_field.name);
                        if let Some(value) = map_value(category_field, peek) {
                            preferences.push(Preference {
                                title: category_field.name.to_title_case(),
                                default_value: !changed.contains(&path),
                                key: path,
                                category: category.clone(),
                                group: None,
                                value,
                            });
                        } else {
                            tracing::warn!(
                                "Unknown type for setting @ {path}: {category_field:?} {peek:?}"
                            );
                        }
                    }
                }
            }
        }

        preferences
    }
}

fn map_value(field: Field, peek: Peek) -> Option<PreferenceValue> {
    let shape = field.shape.get();
    let value = match (shape.def, shape.ty) {
        (_, Type::Primitive(PrimitiveType::Boolean)) => {
            Some(PreferenceValue::Boolean(peek.get::<bool>().copied().ok()?))
        }
        (_, Type::User(UserType::Enum(_))) => {
            let enum_ = peek.into_enum().ok()?;
            let selected = enum_.clone().active_variant().ok()?;
            let name = selected.rename.unwrap_or(selected.name);
            let options = enum_
                .variants()
                .iter()
                .map(|variant| SelectOption {
                    title: variant.name.to_title_case(),
                    value: variant.rename.unwrap_or(variant.name).to_string(),
                })
                .collect();

            Some(PreferenceValue::Select {
                selected: name.to_string(),
                options,
            })
        }
        (Def::List(def), Type::User(UserType::Opaque)) if def.t().type_identifier == "PathBuf" => {
            let path_list = peek.get::<Vec<PathBuf>>().ok()?;

            Some(PreferenceValue::PathList(path_list.clone()))
        }
        (_, Type::User(UserType::Opaque)) if shape.type_identifier == "PathBuf" => {
            let path = peek.get::<PathBuf>().ok()?;

            Some(PreferenceValue::Path(path.clone()))
        }
        _ => None,
    }?;

    Some(value)
}

