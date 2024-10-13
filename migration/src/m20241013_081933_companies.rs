use loco_rs::schema::table_auto_tz;
use sea_orm_migration::{prelude::*, schema::*};

#[derive(DeriveMigrationName)]
pub struct Migration;

#[async_trait::async_trait]
impl MigrationTrait for Migration {
    async fn up(&self, manager: &SchemaManager) -> Result<(), DbErr> {
        manager
            .create_table(
                table_auto_tz(Companies::Table)
                    .col(pk_auto(Companies::Id))
                    .col(uuid_uniq(Companies::InternalId))
                    .col(string_uniq(Companies::CompanyName))
                    .col(string_uniq(Companies::CompanyTaxNumber))
                    .col(string_null(Companies::CompanyCountry))
                    .col(string_null(Companies::CompanyProvince))
                    .col(string_null(Companies::CompanyPostalCode))
                    .col(string_null(Companies::CompanySettlement))
                    .col(string_null(Companies::CompanyStreet))
                    .col(string_null(Companies::CompanyStreetNumber))
                    .col(string_null(Companies::CompanyEmail))
                    .col(string_null(Companies::CompanyPhoneNumber))
                    .to_owned(),
            )
            .await
    }

    async fn down(&self, manager: &SchemaManager) -> Result<(), DbErr> {
        manager
            .drop_table(Table::drop().table(Companies::Table).to_owned())
            .await
    }
}

#[derive(DeriveIden)]
enum Companies {
    Table,
    Id,
    InternalId,
    CompanyName,
    CompanyTaxNumber,
    CompanyCountry,
    CompanyProvince,
    CompanyPostalCode,
    CompanySettlement,
    CompanyStreet,
    CompanyStreetNumber,
    CompanyEmail,
    CompanyPhoneNumber,
    
}


