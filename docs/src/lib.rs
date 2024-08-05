use heck::ToSnakeCase;

include!(concat!(env!("OUT_DIR"), "/docs.rs"));

pub fn get_node_description(name: &str) -> Option<&'static str> {
    NODE_DESCRIPTIONS.get(name).copied()
}

pub fn list_node_settings(
    node: &str,
) -> Option<impl Iterator<Item = (&'static str, &'static str)>> {
    NODE_SETTINGS.get(node).map(|settings| {
        settings
            .entries()
            .map(|(setting, description)| (*setting, *description))
    })
}

pub fn get_node_setting(node: &str, setting: &str) -> Option<&'static str> {
    NODE_SETTINGS
        .get(node)
        .and_then(|settings| settings.get(setting).copied())
}

pub fn get_node_template_description(node: &str, name: &str) -> Option<&'static str> {
    NODE_TEMPLATE_DESCRIPTIONS
        .get(node)
        .and_then(|templates| templates.get(&name.to_snake_case()).copied())
}
