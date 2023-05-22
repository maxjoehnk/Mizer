use super::ObjectSafeProjectMigration;
use crate::versioning::migrations::ProjectFileMigration;
use crate::versioning::{get_version, write_version};

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

            fn migrate(&self, project: &mut String) -> anyhow::Result<()>;
        }
    }
}

impl<T: ProjectFileMigration> ObjectSafeProjectMigration for T {
    #[inline]
    fn version(&self) -> usize {
        T::VERSION
    }

    fn migrate(&self, project: &mut String) -> anyhow::Result<()> {
        let version = get_version(project)?;
        log::info!("Migrating project file from {} to {}", version, T::VERSION);
        self.migrate(project)?;
        write_version(project, T::VERSION)?;

        Ok(())
    }
}
