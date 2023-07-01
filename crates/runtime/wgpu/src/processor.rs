use crate::{WgpuContext, WgpuPipeline};
use mizer_module::{ClockFrame, Injector, Processor};

pub struct WgpuPipelineProcessor;

impl Processor for WgpuPipelineProcessor {
    fn post_process(&mut self, injector: &Injector, _frame: ClockFrame) {
        profiling::scope!("WgpuPipelineProcessor::post_process");
        let pipeline = injector.get::<WgpuPipeline>().unwrap();
        let context = injector.get::<WgpuContext>().unwrap();

        pipeline.render(context);
    }
}
