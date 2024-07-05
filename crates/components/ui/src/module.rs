use mizer_module::{Module, module_name, ModuleContext};
use crate::dialog::DialogService;
use crate::UiApi;

pub struct UiApiModule;

module_name!(UiApiModule);

impl Module for UiApiModule {
    const IS_REQUIRED: bool = false;

    fn register(self, context: &mut impl ModuleContext) -> anyhow::Result<()> {
        let api = UiApi::new();

        let dialog_service = DialogService::new(api.clone());

        context.provide(dialog_service);
        context.provide_api(api);

        Ok(())
    }
}
