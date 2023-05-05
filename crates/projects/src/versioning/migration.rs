use super::ObjectSafeProjectMigration;
use crate::versioning::migrations::ProjectMigration;
use crate::Project;

#[macro_export]
macro_rules! migrations {
    ($($variant:ident),*,) => {
        #[enum_dispatch::enum_dispatch]
        #[derive(Clone, Copy, enum_iterator::Sequence)]
        pub enum Migrations {
            $($variant),*
        }

        $(
            impl enum_iterator::Sequence for $variant {
                const CARDINALITY: usize = 1;

                fn next(&self) -> Option<Self> {
                    None
                }

                fn previous(&self) -> Option<Self> {
                    None
                }

                fn first() -> Option<Self> {
                    Some(Self)
                }

                fn last() -> Option<Self> {
                    Some(Self)
                }
            }
        )*


        #[enum_dispatch::enum_dispatch(Migrations)]
        pub(super) trait ObjectSafeProjectMigration {
            fn version(&self) -> usize;

            fn migrate(&self, project: &mut crate::Project) -> anyhow::Result<()>;
        }
    }
}

impl<T: ProjectMigration> ObjectSafeProjectMigration for T {
    #[inline]
    fn version(&self) -> usize {
        T::VERSION
    }

    fn migrate(&self, project: &mut Project) -> anyhow::Result<()> {
        log::info!(
            "Migrating project file from {} to {}",
            project.version,
            T::VERSION
        );
        self.migrate(project)?;
        project.version = T::VERSION;

        Ok(())
    }
}
