use serde::{Deserialize, Serialize};

pub use add_group::*;
pub use add_preset::*;
pub use assign_programmer_to_group::*;
pub use assign_fixtures_to_group::*;
pub use delete_fixtures::*;
pub use delete_group::*;
pub use delete_preset::*;
pub use patch_fixtures::*;
pub use rename_group::*;
pub use rename_preset::*;
pub use store_in_preset::*;
pub use update_fixture::*;
pub use select_fixtures::*;
pub use call_preset::*;
pub use call_group::*;
pub use call_effect::*;
pub use clear_programmer::*;
pub use toggle_highlight::*;

mod add_group;
mod add_preset;
mod assign_programmer_to_group;
mod assign_fixtures_to_group;
mod call_preset;
mod call_group;
mod call_effect;
mod clear_programmer;
mod delete_fixtures;
mod delete_group;
mod delete_preset;
mod patch_fixtures;
mod rename_group;
mod rename_preset;
mod store_in_preset;
mod update_fixture;
mod select_fixtures;
mod toggle_highlight;

#[derive(Debug, Clone, Copy, Deserialize, Serialize)]
pub enum StoreGroupMode {
    Overwrite,
    Merge,
    Subtract,
}
