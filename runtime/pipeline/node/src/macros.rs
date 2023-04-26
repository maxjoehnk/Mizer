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
