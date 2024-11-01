use loco_rs::schema::table_auto_tz;
use sea_orm_migration::{prelude::*, schema::*};

#[derive(DeriveMigrationName)]
pub struct Migration;

#[async_trait::async_trait]
impl MigrationTrait for Migration {
    async fn up(&self, manager: &SchemaManager) -> Result<(), DbErr> {
        manager
            .create_table(
                table_auto_tz(Pesticides::Table)
                    .col(pk_auto(Pesticides::Id))
                    .col(
                        ColumnDef::new(Pesticides::InternalId)
                            .uuid()  // Defines it as a UUID type column
                            .not_null()
                            .unique_key()
                            .default(Expr::cust("uuid_generate_v4()")),  // PostgreSQL function to auto-generate UUID
                    )
                    .col(string_uniq(Pesticides::PesticideName))
                    .col(string_null(Pesticides::PesticideType))
                    .col(string_null(Pesticides::PesticideSubstance1))
                    .col(string_null(Pesticides::PesticideSubstance2))
                    .col(string_null(Pesticides::PesticideSubstance3))
                    .col(string_null(Pesticides::PesticideSubstance4))
                    .col(string_null(Pesticides::PesticideAntidote1))
                    .col(string_null(Pesticides::PesticideAntidote2))
                    .to_owned(),
            )
            .await
    }

    async fn down(&self, manager: &SchemaManager) -> Result<(), DbErr> {
        manager
            .drop_table(Table::drop().table(Pesticides::Table).to_owned())
            .await
    }
}

#[derive(DeriveIden)]
enum Pesticides {
    Table,
    Id,
    InternalId,
    PesticideName,
    PesticideType,
    PesticideSubstance1,
    PesticideSubstance2,
    PesticideSubstance3,
    PesticideSubstance4,
    PesticideAntidote1,
    PesticideAntidote2,
    
}


