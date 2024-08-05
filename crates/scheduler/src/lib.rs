#![allow(async_fn_in_trait)]
use std::future::Future;
use std::time::Duration;
use futures::future::BoxFuture;
use futures::FutureExt;

pub mod job_pool;

pub trait JobContext: Send + Sync {
    fn queue_task(&self, task: Box<dyn BackgroundTask>);
}

/// Background jobs are long running tasks that are executed in the background.
pub trait BackgroundJob: Send + Sync {
    async fn run(&self, job_context: &dyn JobContext) -> anyhow::Result<()>;
}

pub trait BackgroundTask: Send + Sync {
    fn run(&self) -> anyhow::Result<()>;
}

pub trait AsyncBackgroundTask: Send + Sync {
    async fn run(&self) -> anyhow::Result<()>;
}

impl<T: AsyncBackgroundTask> BackgroundTask for T {
    fn run(&self) -> anyhow::Result<()> {
        tokio::runtime::Handle::current().block_on(self.run())
    }
}

#[derive(Clone, Copy)]
pub enum JobSchedule {
    Pause(Duration),
}

impl JobSchedule {
    pub async fn wait(&self) {
        match self {
            JobSchedule::Pause(duration) => tokio::time::sleep(*duration).await
        }
    }
}

pub struct PeriodicTask(Box<dyn PeriodicTaskSchedule>);

pub trait PeriodicTaskSchedule: Send + Sync {
    // Cannot be associated value because that would not be object safe
    fn schedule(&self) -> JobSchedule;

    fn create_task(&self) -> Box<dyn BackgroundTask>;
}

impl BackgroundJob for PeriodicTask {
    async fn run(&self, job_context: &dyn JobContext) -> anyhow::Result<()> {
        loop {
            job_context.queue_task(self.0.create_task());
            self.0.schedule().wait().await;
        }
    }
}

pub trait EventJobSchedule: Send + Sync {
    type Event: 'static + Send + Sync;

    fn next_event(&self) -> impl Future<Output = Option<Self::Event>> + Send;

    fn create_task(&self, event: Self::Event) -> Box<dyn BackgroundTask>;
}

trait EventJobScheduleDyn: Send + Sync {
    fn run_once<'a, 'b>(&'a self, job_context: &'b dyn JobContext) -> BoxFuture<'b, anyhow::Result<()>>
        where
            'a: 'b;
}

impl<T: EventJobSchedule> EventJobScheduleDyn for T {
    fn run_once<'a, 'b>(&'a self, job_context: &'b dyn JobContext) -> BoxFuture<'b, anyhow::Result<()>>
        where
            'a: 'b {
        async {
            if let Some(event) = self.next_event().await {
                job_context.queue_task(self.create_task(event));
            }

            Ok(())
        }.boxed()
    }
}

pub struct EventJob(Box<dyn EventJobScheduleDyn>);

impl BackgroundJob for EventJob {
    async fn run(&self, job_context: &dyn JobContext) -> anyhow::Result<()> {
        loop {
            self.0.run_once(job_context).await?;
        }
    }
}
