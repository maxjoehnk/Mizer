pub use bevy_ecs::prelude::*;

pub use bevy_ecs;
use bevy_ecs::schedule::ScheduleLabel;

#[derive(ScheduleLabel, Debug, Clone, Copy, Hash, Eq, PartialEq)]
struct MainSchedule;

#[derive(SystemSet, Debug, Clone, Copy, Hash, Eq, PartialEq)]
pub struct PreProcess;

#[derive(SystemSet, Debug, Clone, Copy, Hash, Eq, PartialEq)]
pub struct Process;

#[derive(SystemSet, Debug, Clone, Copy, Hash, Eq, PartialEq)]
pub struct PostProcess;

#[derive(SystemSet, Debug, Clone, Copy, Hash, Eq, PartialEq)]
struct BackgroundJobs;

#[derive(Component, Debug, Default, Clone)]
pub struct EntityErrors(Vec<String>);

pub struct EcsContext {
    pub world: World,
}

impl EcsContext {
    pub fn new() -> Self {
        let mut world = World::new();
        world.add_schedule(Schedule::new(MainSchedule));

        Self { world }
    }
    
    pub fn add_system<M>(&mut self, set: impl SystemSet + Copy, system: impl IntoSystemConfigs<M>) {
        let mut schedules = self.world.resource_mut::<Schedules>();
        let schedule = schedules.get_mut(MainSchedule).unwrap();
        schedule.add_systems(system.in_set(set));
    }
    
    pub fn run(&mut self) {
        self.world.run_schedule(MainSchedule);
    }
    
    pub fn add_background_job<TCommands: Event + Clone, TEvents: Event>(&mut self) -> BackgroundJobHandle<TCommands, TEvents> {
        let (job, handle) = BackgroundJob::new();
        self.world.insert_resource(job);
        self.world.init_resource::<Events<TCommands>>();
        self.add_system(PreProcess,
            bevy_ecs::event::event_update_system::<TCommands>
                .in_set(bevy_ecs::event::EventUpdates)
                .run_if(bevy_ecs::event::event_update_condition::<TCommands>),
        );
        self.world.init_resource::<Events<TEvents>>();
        self.add_system(PreProcess,
                        bevy_ecs::event::event_update_system::<TEvents>
                            .in_set(bevy_ecs::event::EventUpdates)
                            .run_if(bevy_ecs::event::event_update_condition::<TEvents>),
        );
        self.add_system(BackgroundJobs, background_job_system::<TCommands, TEvents>);

        handle
    }
}

fn background_job_system<Commands: Event + Clone, Events: Event>(mut events: EventWriter<Events>, mut commands: EventReader<Commands>, job: Res<BackgroundJob<Commands, Events>>) {
    for command in commands.read() {
        job.handle_command(command.clone());
    }
    
    for event in job.iter_events() {
        events.send(event);
    }
}

pub struct BackgroundJobHandle<Commands, Events> {
    commands: flume::Receiver<Commands>,
    events: flume::Sender<Events>,
}

impl<Commands, Events> BackgroundJobHandle<Commands, Events> {
    pub fn send_event(&self, event: Events) {
        self.events.send(event).unwrap();
    }

    pub fn get_commands(&self) -> Vec<Commands> {
        self.commands.try_iter().collect()
    }
}

#[derive(Resource)]
struct BackgroundJob<Commands, Events> {
    commands: flume::Sender<Commands>,
    events: flume::Receiver<Events>,
}

impl<Commands, Events> BackgroundJob<Commands, Events> {
    fn new() -> (Self, BackgroundJobHandle<Commands, Events>) {
        let (commands, commands_rx) = flume::unbounded();
        let (events_tx, events) = flume::unbounded();
        
        let job = Self {
            commands,
            events,
        };
        let handle = BackgroundJobHandle { commands: commands_rx, events: events_tx };

        (job, handle)
    }
    
    pub fn handle_command(&self, command: Commands) {
        self.commands.send(command).unwrap();
    }
    
    pub fn iter_events(&self) -> impl Iterator<Item=Events> + '_ {
        self.events.try_iter()
    }
}

pub struct AsyncTask {

}
