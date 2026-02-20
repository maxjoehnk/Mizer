use mizer_module::{ClockFrame, Inject, Injector, Processor, ProcessorPriorities};

use crate::{WgpuContext, WgpuPipeline};

pub struct WgpuPipelineProcessor;

impl Processor for WgpuPipelineProcessor {
    fn priorities(&self) -> ProcessorPriorities {
        ProcessorPriorities {
            process: 100,
            post_process: 100,
            ..Default::default()
        }
    }

    fn process(&mut self, injector: &mut Injector, _frame: ClockFrame) {
        profiling::scope!("WgpuPipelineProcessor::process");
        let pipeline = injector.get::<WgpuPipeline>().unwrap();
        let wgpu_context = injector.get::<WgpuContext>().unwrap();

        pipeline.render(wgpu_context);
        pipeline.map_buffers(wgpu_context);
    }

    fn post_process(&mut self, injector: &mut Injector, _frame: ClockFrame) {
        profiling::scope!("WgpuPipelineProcessor::post_process");
        let pipeline = injector.inject::<WgpuPipeline>();

        pipeline.cleanup();
    }
}
