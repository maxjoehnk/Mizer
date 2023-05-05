use std::collections::HashMap;
use std::ffi::{c_char, CString};

#[derive(Default)]
pub struct PointerInventory {
    strings: HashMap<*const c_char, CString>,
}

impl PointerInventory {
    pub fn allocate_string(&mut self, value: String) -> *const c_char {
        let value = CString::new(value).unwrap();
        let value_pointer = value.as_ptr();
        self.strings.insert(value_pointer, value);

        value_pointer
    }
}
