// use crate::pipeline_access::PipelineAccess;
// use mizer_clock::ClockFrame;
// use mizer_module::{Injector, Module, Runtime};
// use mizer_processing::Processor;

// pub struct RuntimeModule {}
//
// impl Module for RuntimeModule {
//     fn register(self, runtime: &mut dyn Runtime) -> anyhow::Result<()> {
//         runtime.injector_mut().provide(PipelineAccess::new());
//         runtime.add_processor(Box::new(RuntimeProcessor));
//
//         Ok(())
//     }
// }
//
// pub struct RuntimeProcessor;
//
// impl Processor for RuntimeProcessor {
//     fn process(&mut self, injector: &Injector, frame: ClockFrame) {
//         let pipeline_access = injector.get::<PipelineAccess>().unwrap();
//         let nodes = pipeline_access
//             .nodes
//             .iter()
//             // .filter(|(path, _)| self.assigned_nodes.contains(path))
//             .collect::<Vec<_>>(); // run filter closure here so mutable and immutable borrow is okay
//
//         self.pipeline.process(nodes, frame, &injector);
//     }
// }
