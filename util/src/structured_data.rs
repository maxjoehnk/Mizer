use serde::{Deserialize, Serialize};
use std::collections::HashMap;
use std::str::FromStr;

#[derive(Debug, Clone, PartialEq, Deserialize, Serialize)]
#[serde(untagged)]
pub enum StructuredData {
    Text(String),
    Float(f64),
    Int(i64),
    Boolean(bool),
    Array(Vec<StructuredData>),
    Object(HashMap<String, StructuredData>),
}

impl Default for StructuredData {
    fn default() -> Self {
        // TODO: should this be the default?
        Self::Boolean(false)
    }
}

impl StructuredData {
    pub fn access(&self, path: &str) -> Option<&StructuredData> {
        let mut data = Some(self);
        for part in path.split('.') {
            data = match data {
                Some(StructuredData::Object(map)) => map.get(part),
                Some(StructuredData::Array(items)) => {
                    if let Ok(index) = usize::from_str(part) {
                        items.get(index)
                    } else {
                        None
                    }
                }
                _ => None,
            };
        }

        data
    }
}

#[cfg(test)]
mod tests {
    use crate::StructuredData;
    use std::collections::HashMap;
    use test_case::test_case;

    #[test_case("key", StructuredData::Boolean(false))]
    #[test_case("bool", StructuredData::Boolean(true))]
    #[test_case("int", StructuredData::Int(2))]
    fn access_should_return_data_for_object(key: &str, value: StructuredData) {
        let mut map = HashMap::new();
        map.insert(key.to_string(), value.clone());
        let data = StructuredData::Object(map);

        let result = data.access(key);

        assert_eq!(Some(&value), result);
    }

    #[test]
    fn access_should_return_data_from_nested_objects() {
        let value = StructuredData::Boolean(true);
        let mut last_map = HashMap::new();
        last_map.insert("last".to_string(), value.clone());
        let mut second_map = HashMap::new();
        second_map.insert("second".to_string(), StructuredData::Object(last_map));
        let mut first_map = HashMap::new();
        first_map.insert("first".to_string(), StructuredData::Object(second_map));
        let data = StructuredData::Object(first_map);

        let result = data.access("first.second.last");

        assert_eq!(Some(&value), result);
    }

    #[test_case("0", StructuredData::Boolean(true))]
    #[test_case("1", StructuredData::Boolean(false))]
    fn access_should_return_data_from_arrays(path: &str, expected: StructuredData) {
        let data = StructuredData::Array(vec![
            StructuredData::Boolean(true),
            StructuredData::Boolean(false),
        ]);

        let result = data.access(path);

        assert_eq!(Some(&expected), result);
    }

    #[test]
    fn access_should_return_none_when_out_of_bounds_for_arrays() {
        let data = StructuredData::Array(vec![
            StructuredData::Boolean(true),
            StructuredData::Boolean(false),
        ]);

        let result = data.access("2");

        assert_eq!(None, result);
    }

    #[test]
    fn access_should_combine_array_and_object_path_operators() {
        let value = StructuredData::Boolean(true);
        let array = vec![value.clone()];
        let array = StructuredData::Array(array);
        let mut map = HashMap::new();
        map.insert("array".to_string(), array);
        let data = StructuredData::Object(map);

        let result = data.access("array.0");

        assert_eq!(Some(&value), result)
    }
}
