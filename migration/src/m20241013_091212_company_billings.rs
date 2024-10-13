use loco_rs::schema::table_auto_tz;
use sea_orm_migration::{prelude::*, schema::*};

#[derive(DeriveMigrationName)]
pub struct Migration;

#[async_trait::async_trait]
impl MigrationTrait for Migration {
    async fn up(&self, manager: &SchemaManager) -> Result<(), DbErr> {
        manager
            .create_table(
                table_auto_tz(CompanyBillings::Table)
                    .col(pk_auto(CompanyBillings::Id))
                    .col(
                        ColumnDef::new(CompanyBillings::InternalId)
                            .uuid()  // Defines it as a UUID type column
                            .not_null()
                            .unique_key()
                            .default(Expr::cust("uuid_generate_v4()")),  // PostgreSQL function to auto-generate UUID
                    )
                    .col(string_uniq(CompanyBillings::BillingCompanyName))
                    .col(string_uniq(CompanyBillings::BillingTaxNumber))
                    .col(string_null(CompanyBillings::BillingEmail))
                    .col(string_null(CompanyBillings::BillingCountry))
                    .col(string_null(CompanyBillings::BillingProvince))
                    .col(string_null(CompanyBillings::BillingPostalCode))
                    .col(string_null(CompanyBillings::BillingSettlement))
                    .col(string_null(CompanyBillings::BillingStreet))
                    .col(string_null(CompanyBillings::BillingStreetNumber))
                    .col(integer(CompanyBillings::CompanyId))
                    .foreign_key(
                        ForeignKey::create()
                            .name("fk-company_billings-companies")
                            .from(CompanyBillings::Table, CompanyBillings::CompanyId)
                            .to(Companies::Table, Companies::Id)
                            .on_delete(ForeignKeyAction::Cascade)
                            .on_update(ForeignKeyAction::Cascade),
                    )
                    .to_owned(),
            )
            .await
    }

    async fn down(&self, manager: &SchemaManager) -> Result<(), DbErr> {
        manager
            .drop_table(Table::drop().table(CompanyBillings::Table).to_owned())
            .await
    }
}

#[derive(DeriveIden)]
enum CompanyBillings {
    Table,
    Id,
    InternalId,
    BillingCompanyName,
    BillingTaxNumber,
    BillingEmail,
    BillingCountry,
    BillingProvince,
    BillingPostalCode,
    BillingSettlement,
    BillingStreet,
    BillingStreetNumber,
    CompanyId,
    
}


#[derive(DeriveIden)]
enum Companies {
    Table,
    Id,
}
