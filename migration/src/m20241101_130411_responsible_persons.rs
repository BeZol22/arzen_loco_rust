use loco_rs::schema::table_auto_tz;
use sea_orm_migration::{prelude::*, schema::*};

#[derive(DeriveMigrationName)]
pub struct Migration;

#[async_trait::async_trait]
impl MigrationTrait for Migration {
    async fn up(&self, manager: &SchemaManager) -> Result<(), DbErr> {
        manager
            .create_table(
                table_auto_tz(ResponsiblePersons::Table)
                    .col(pk_auto(ResponsiblePersons::Id))
                    .col(
                        ColumnDef::new(ResponsiblePersons::InternalId)
                            .uuid()  // Defines it as a UUID type column
                            .not_null()
                            .unique_key()
                            .default(Expr::cust("uuid_generate_v4()")),  // PostgreSQL function to auto-generate UUID
                    )
                    .col(string_null(ResponsiblePersons::ResponsiblePersonName))
                    .col(string_uniq(ResponsiblePersons::ResponsiblePersonLicense))
                    .to_owned(),
            )
            .await
    }

    async fn down(&self, manager: &SchemaManager) -> Result<(), DbErr> {
        manager
            .drop_table(Table::drop().table(ResponsiblePersons::Table).to_owned())
            .await
    }
}

#[derive(DeriveIden)]
enum ResponsiblePersons {
    Table,
    Id,
    InternalId,
    ResponsiblePersonName,
    ResponsiblePersonLicense,
    
}


