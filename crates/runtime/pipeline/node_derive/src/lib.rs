use darling::FromDeriveInput;
use proc_macro2::TokenStream;
use syn::{parse_macro_input};

mod node;

#[proc_macro_derive(Node, attributes(setting))]
pub fn node_derive(input: proc_macro::TokenStream) -> proc_macro::TokenStream {
    let input = parse_macro_input!(input as syn::DeriveInput);

    let node = node::Node::from_derive_input(&input).unwrap();

    let name = node.ident;

    let fields = node.data.take_struct().unwrap().fields;

    let mut settings = Vec::new();
    let mut update_settings = Vec::new();

    for field in fields {
        let name = field.ident.unwrap();
        let label = field.label
            .map(|label| quote::quote!(Some(#label.into())))
            .unwrap_or_else(|| quote::quote!(Some(mizer_node::setting_label(stringify!(#name)).into())));

        let mut transformations = Vec::new();
        if let Some(min) = field.min {
            transformations.push(quote::quote! {
                setting = setting.min(#min);
            });
        }
        if let Some(min_hint) = field.min_hint {
            transformations.push(quote::quote! {
                setting = setting.min_hint(#min_hint);
            });
        }
        if let Some(max) = field.max {
            transformations.push(quote::quote! {
                setting = setting.max(#max);
            });
        }
        if let Some(max_hint) = field.max_hint {
            transformations.push(quote::quote! {
                setting = setting.max_hint(#max_hint);
            });
        }

        let field_stream: TokenStream = quote::quote! {
            let mut setting = mizer_node::NodeSetting {
                id: stringify!(#name).into(),
                value: self.#name.into(),
                category: Default::default(),
                description: Default::default(),
                disabled: Default::default(),
                optional: Default::default(),
                label: #label,
            };

            #(#transformations)*

            settings.push(setting);
        }.into();

        settings.push(field_stream);

        let field_stream: TokenStream = quote::quote! {
            if matches!(setting.value, NodeSettingValue::Float { .. }) && setting.id == stringify!(#name) {
                if let NodeSettingValue::Float { value, .. } = setting.value {
                    self.#name = value.try_into()?;
                    return Ok(());
                }
            }
        };

        update_settings.push(field_stream);
    }

    let expanded = quote::quote! {
        impl mizer_node::ConfigurableNode for #name {
            fn settings(&self, _injector: &Injector) -> Vec<mizer_node::NodeSetting> {
                let mut settings = Vec::new();

                #(#settings)*

                settings
            }

            fn update_setting(&mut self, setting: NodeSetting) -> anyhow::Result<()> {
                #(#update_settings)*

                update_fallback!(setting)
            }
        }
    };

    proc_macro::TokenStream::from(expanded)
}
