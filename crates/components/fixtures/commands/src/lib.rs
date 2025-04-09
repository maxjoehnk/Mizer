use serde::{Deserialize, Serialize};

pub use add_group::*;
pub use assign_fixtures_to_group::*;
pub use assign_programmer_to_group::*;
pub use call_effect::*;
pub use call_group::*;
pub use call_preset::*;
pub use clear_programmer::*;
pub use delete_fixtures::*;
pub use delete_group::*;
pub use delete_preset::*;
pub use patch_fixtures::*;
pub use rename_group::*;
pub use rename_preset::*;
pub use select_fixtures::*;
pub use toggle_highlight::*;
pub use update_fixture::*;
pub use write_programmer::*;
pub use store_preset::*;

mod add_group;
mod assign_fixtures_to_group;
mod assign_programmer_to_group;
mod call_effect;
mod call_group;
mod call_preset;
mod clear_programmer;
mod delete_fixtures;
mod delete_group;
mod delete_preset;
mod patch_fixtures;
mod rename_group;
mod rename_preset;
mod select_fixtures;
mod toggle_highlight;
mod update_fixture;
mod store_preset;
mod write_programmer;

#[derive(Debug, Clone, Copy, Deserialize, Serialize)]
pub enum StoreGroupMode {
    Overwrite,
    Merge,
    Subtract,
}
