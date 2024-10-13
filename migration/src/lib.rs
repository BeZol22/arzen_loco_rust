#![allow(elided_lifetimes_in_paths)]
#![allow(clippy::wildcard_imports)]
pub use sea_orm_migration::prelude::*;

mod m20220101_000001_users;
mod m20231103_114510_notes;

mod m20241013_081933_companies;
mod m20241013_084731_company_contacts;
mod m20241013_091212_company_billings;
mod m20241013_164100_company_premises;
pub struct Migrator;

#[async_trait::async_trait]
impl MigratorTrait for Migrator {
    fn migrations() -> Vec<Box<dyn MigrationTrait>> {
        vec![
            Box::new(m20220101_000001_users::Migration),
            Box::new(m20231103_114510_notes::Migration),
            Box::new(m20241013_081933_companies::Migration),
            Box::new(m20241013_084731_company_contacts::Migration),
            Box::new(m20241013_091212_company_billings::Migration),
            Box::new(m20241013_164100_company_premises::Migration),
        ]
    }
}