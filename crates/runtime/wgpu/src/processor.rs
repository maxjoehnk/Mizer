use mizer_module::{ClockFrame, Inject, InjectionScope, Processor, ProcessorPriorities};

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

    fn process(&mut self, injector: &InjectionScope, _frame: ClockFrame) {
        profiling::scope!("WgpuPipelineProcessor::process");
        let pipeline = injector.inject::<WgpuPipeline>();
        let wgpu_context = injector.inject::<WgpuContext>();

        pipeline.render(wgpu_context);
        pipeline.map_buffers(wgpu_context);
    }

    fn post_process(&mut self, injector: &InjectionScope, _frame: ClockFrame) {
        profiling::scope!("WgpuPipelineProcessor::post_process");
        let pipeline = injector.inject::<WgpuPipeline>();

        pipeline.cleanup();
    }
}
