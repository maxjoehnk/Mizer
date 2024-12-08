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
        pub(super) trait ProjectMigration {
            fn version(&self) -> u32;

            fn migrate(&self, project: &mut ProjectFile) -> anyhow::Result<()>;
        }
    }
}

// These macros exist because we cannot use specialization to generate different implementations for the ProjectMigration trait

#[macro_export]
macro_rules! yaml_migrations {
    ($($variant:ident),*,) => {
        $(
            yaml_migration!($variant);
        )*
    }
}

#[macro_export]
macro_rules! yaml_migration {
    ($variant:ident) => {
        impl ProjectMigration for $variant {
            #[inline]
            fn version(&self) -> u32 {
                <$variant as ProjectFileMigration>::VERSION
            }

            fn migrate(&self, project_file: &mut ProjectFile) -> anyhow::Result<()> {
                let version = project_file.get_version()?;
                tracing::info!("Migrating project file from {} to {}", version, <$variant as ProjectFileMigration>::VERSION);
                let file_content = project_file.as_yaml()
                    .ok_or_else(|| anyhow::anyhow!("Trying to apply yaml migration on new project file"))?;
                ProjectFileMigration::migrate(self, file_content)?;
                project_file.write_version(<$variant as ProjectFileMigration>::VERSION)?;

                Ok(())
            }
        }
    };
}

#[macro_export]
macro_rules! archive_migrations {
    ($($variant:ident),*,) => {
        $(
            archive_migration!($variant);
        )*
    }
}

#[macro_export]
macro_rules! archive_migration {
    ($variant:ident) => {
        impl ProjectMigration for $variant {
            #[inline]
            fn version(&self) -> u32 {
                <$variant as ProjectArchiveMigration>::VERSION
            }

            fn migrate(&self, project_file: &mut ProjectFile) -> anyhow::Result<()> {
                let version = project_file.get_version()?;
                tracing::info!("Migrating project file from {} to {}", version, <$variant as ProjectArchiveMigration>::VERSION);
                let file_content = project_file.as_archive()
                    .ok_or_else(|| anyhow::anyhow!("Trying to apply archive migration on old project file"))?;
                ProjectArchiveMigration::migrate(self, file_content)?;
                project_file.write_version(<$variant as ProjectArchiveMigration>::VERSION)?;

                Ok(())
            }
        }
    };
}
