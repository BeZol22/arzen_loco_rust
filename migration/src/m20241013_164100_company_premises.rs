use loco_rs::schema::table_auto_tz;
use sea_orm_migration::{prelude::*, schema::*};

#[derive(DeriveMigrationName)]
pub struct Migration;

#[async_trait::async_trait]
impl MigrationTrait for Migration {
    async fn up(&self, manager: &SchemaManager) -> Result<(), DbErr> {
        manager
            .create_table(
                table_auto_tz(CompanyPremises::Table)
                    .col(pk_auto(CompanyPremises::Id))
                    .col(
                        ColumnDef::new(CompanyPremises::InternalId)
                            .uuid()  // Defines it as a UUID type column
                            .not_null()
                            .unique_key()
                            .default(Expr::cust("uuid_generate_v4()")),  // PostgreSQL function to auto-generate UUID
                    )
                    .col(string_null(CompanyPremises::PremiseCompanyName))
                    .col(string_null(CompanyPremises::PremiseCountry))
                    .col(string_null(CompanyPremises::PremiseEmail))
                    .col(string_null(CompanyPremises::PremisePhoneNumber))
                    .col(string_null(CompanyPremises::PremisePostalCode))
                    .col(string_null(CompanyPremises::PremiseProvince))
                    .col(string_null(CompanyPremises::PremiseSettlement))
                    .col(string_null(CompanyPremises::PremiseStreet))
                    .col(string_null(CompanyPremises::PremiseStreetNumber))
                    .col(
                        ColumnDef::new(CompanyPremises::CompanyIid)  // Foreign key column for internal_id
                            .uuid()  // Defines it as a UUID type
                            .not_null(),
                    )
                    .foreign_key(
                        ForeignKey::create()
                            .name("fk-company_billings-companies")
                            .from(CompanyPremises::Table, CompanyPremises::CompanyIid)
                            .to(Companies::Table, Companies::InternalId)
                            .on_delete(ForeignKeyAction::Cascade)
                            .on_update(ForeignKeyAction::Cascade),
                    )
                    .to_owned(),
            )
            .await
    }

    async fn down(&self, manager: &SchemaManager) -> Result<(), DbErr> {
        manager
            .drop_table(Table::drop().table(CompanyPremises::Table).to_owned())
            .await
    }
}

#[derive(DeriveIden)]
enum CompanyPremises {
    Table,
    Id,
    InternalId,
    PremiseCompanyName,
    PremiseCountry,
    PremiseEmail,
    PremisePhoneNumber,
    PremisePostalCode,
    PremiseProvince,
    PremiseSettlement,
    PremiseStreet,
    PremiseStreetNumber,
    CompanyIid,
    
}


#[derive(DeriveIden)]
enum Companies {
    Table,
    InternalId,
}
