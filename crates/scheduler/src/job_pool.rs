use std::sync::Arc;
use std::sync::atomic::AtomicU8;
use crate::BackgroundTask;

pub struct JobPool {
    sender: flume::Sender<Box<dyn BackgroundTask>>,
    stats: PoolStats,
}

#[derive(Clone, Default)]
struct PoolStats {
    running_jobs: Arc<AtomicU8>,
    total_jobs: Arc<AtomicU8>,
}

impl PoolStats {
    pub fn running_jobs(&self) -> u8 {
        self.running_jobs.load(std::sync::atomic::Ordering::Relaxed)
    }
    
    pub fn total_jobs(&self) -> u8 {
        self.total_jobs.load(std::sync::atomic::Ordering::Relaxed)
    }
    
    fn add_pending(&self) {
        self.total_jobs.fetch_add(1, std::sync::atomic::Ordering::Relaxed);
    }
    
    fn start_job(&self) {
        self.running_jobs.fetch_add(1, std::sync::atomic::Ordering::Relaxed);
    }
    
    fn finish_job(&self) {
        self.running_jobs.fetch_sub(1, std::sync::atomic::Ordering::Relaxed);
        self.total_jobs.fetch_sub(1, std::sync::atomic::Ordering::Relaxed);
    }
}

impl JobPool {
    pub fn new() -> Self {
        let (sender, receiver) = flume::unbounded();
        let stats = PoolStats::default();
        
        let job_count = num_cpus::get().saturating_sub(2).min(1);
        for _ in 0..job_count {
            let receiver = receiver.clone();
            JobRunner::spawn(receiver, stats.clone());
        }
        
        Self { sender, stats }
    }
    
    pub fn queue_job(&self, job: impl BackgroundTask + 'static) {
        self.stats.add_pending();
        self.sender.send(Box::new(job)).unwrap();
    }
}

struct JobRunner {
    receiver: flume::Receiver<Box<dyn BackgroundTask>>,
    stats: PoolStats
}

impl JobRunner {
    fn spawn(receiver: flume::Receiver<Box<dyn BackgroundTask>>, stats: PoolStats) {
        std::thread::spawn(|| Self { receiver, stats }.run());
    }

    fn run(self) {
        while let Ok(task) = self.receiver.recv() {
            self.stats.start_job();
            if let Err(err) = task.run() {
                tracing::error!("Error running background task: {err}");
            }
            self.stats.finish_job();
        }
    }
}
