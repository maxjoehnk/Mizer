#[macro_export]
macro_rules! port {
    ($name:expr, $direction:expr, $port_type:expr $(,$key:ident: $value:expr)*) => {
        (
            $name.into(),
            PortMetadata {
                port_type: $port_type,
                direction: $direction,
                $($key: $value,)*
                ..Default::default()
            },
        )
    };
}

#[macro_export]
macro_rules! input_port {
    ($name:expr, $port_type:expr) => {
        $crate::port!($name, PortDirection::Input, $port_type)
    };
    ($name:expr, $port_type:expr, multiple) => {
        $crate::port!($name, PortDirection::Input, $port_type, multiple: Some(true))
    };
    ($name:expr, $port_type:expr, dimensions: ($width:expr, $height:expr)) => {
        $crate::port!($name, PortDirection::Input, $port_type, dimensions: Some(($width, $height)))
    };
    ($name:expr, $port_type:expr, dimensions: $dimensions:expr) => {
        $crate::port!($name, PortDirection::Input, $port_type, dimensions: $dimensions.into())
    };
}

#[macro_export]
macro_rules! output_port {
    ($name:expr, $port_type:expr) => {
        $crate::port!($name, PortDirection::Output, $port_type)
    };
}

#[macro_export]
macro_rules! setting {
    ($name:expr, $value:expr) => {
        NodeSetting {
            label: $name.into(),
            value: $value.into(),
            description: Default::default(),
            disabled: Default::default(),
            optional: Default::default(),
        }
    };
    (enum $name:expr, $value:expr) => {
        $crate::setting!($name, $crate::NodeSettingValue::from_enum($value))
    };
    (select $name:expr, $value:expr, $values:expr) => {
        $crate::setting!(
            $name,
            $crate::NodeSettingValue::select($value.into(), $values)
        )
    };
    (id $name:expr, $value:expr, $values:expr) => {
        $crate::setting!($name, $crate::NodeSettingValue::id($value, $values))
    };
    (media $name:expr, $value:expr, $content_types:expr) => {
        $crate::setting!(
            $name,
            $crate::NodeSettingValue::media($value.into(), $content_types)
        )
    };
}

#[macro_export]
macro_rules! update {
    (enum $setting:expr, $name:expr, $field:expr) => {
        if matches!($setting.value, NodeSettingValue::Enum { .. }) && $setting.label == $name {
            if let NodeSettingValue::Enum { value, .. } = $setting.value {
                $field = value.try_into()?;
                return Ok(());
            }
        }
    };
    (id $setting:expr, $name:expr, $field:expr) => {
        if matches!($setting.value, NodeSettingValue::Id { .. }) && $setting.label == $name {
            if let NodeSettingValue::Id { value, .. } = $setting.value {
                $field = value.into();
                return Ok(());
            }
        }
    };
    (select $setting:expr, $name:expr, $field:expr) => {
        if matches!($setting.value, NodeSettingValue::Select { .. }) && $setting.label == $name {
            if let NodeSettingValue::Select { value, .. } = $setting.value {
                $field = value.try_into()?;
                return Ok(());
            }
        }
    };
    (text $setting:expr, $name:expr, $field:expr) => {
        if matches!($setting.value, NodeSettingValue::Text { .. }) && $setting.label == $name {
            if let NodeSettingValue::Text { value, .. } = $setting.value {
                $field = value;
                return Ok(());
            }
        }
    };
    (float $setting:expr, $name:expr, $field:expr) => {
        if matches!($setting.value, NodeSettingValue::Float { .. }) && $setting.label == $name {
            if let NodeSettingValue::Float { value, .. } = $setting.value {
                $field = value.try_into()?;
                return Ok(());
            }
        }
    };
    (int $setting:expr, $name:expr, $field:expr) => {
        if matches!($setting.value, NodeSettingValue::Int { .. }) && $setting.label == $name {
            if let NodeSettingValue::Int { value, .. } = $setting.value {
                $field = value.try_into()?;
                return Ok(());
            }
        }
    };
    (uint $setting:expr, $name:expr, $field:expr) => {
        if matches!($setting.value, NodeSettingValue::Uint { .. }) && $setting.label == $name {
            if let NodeSettingValue::Uint { value, .. } = $setting.value {
                $field = value.try_into()?;
                return Ok(());
            }
        }
    };
    (bool $setting:expr, $name:expr, $field:expr) => {
        if matches!($setting.value, NodeSettingValue::Bool { .. }) && $setting.label == $name {
            if let NodeSettingValue::Bool { value, .. } = $setting.value {
                $field = value;
                return Ok(());
            }
        }
    };
    (spline $setting:expr, $name:expr, $field:expr) => {
        if matches!($setting.value, NodeSettingValue::Spline(_)) && $setting.label == $name {
            if let NodeSettingValue::Spline(value) = $setting.value {
                $field = value;
                return Ok(());
            }
        }
    };
    (media $setting:expr, $name:expr, $field:expr) => {
        if matches!($setting.value, NodeSettingValue::Media { .. }) && $setting.label == $name {
            if let NodeSettingValue::Media { value, .. } = $setting.value {
                $field = value;
                return Ok(());
            }
        }
    };
    (steps $setting:expr, $name:expr, $field:expr) => {
        if matches!($setting.value, NodeSettingValue::Steps(_)) && $setting.label == $name {
            if let NodeSettingValue::Steps(value) = $setting.value {
                $field = value;
                return Ok(());
            }
        }
    };
}

#[macro_export]
macro_rules! update_fallback {
    ($setting:expr) => {
        Err(anyhow::anyhow!("Invalid setting {:?}", $setting))
    };
}
