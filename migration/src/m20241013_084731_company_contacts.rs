use loco_rs::schema::table_auto_tz;
use sea_orm_migration::{prelude::*, schema::*};

#[derive(DeriveMigrationName)]
pub struct Migration;

#[async_trait::async_trait]
impl MigrationTrait for Migration {
    async fn up(&self, manager: &SchemaManager) -> Result<(), DbErr> {
        manager
            .create_table(
                table_auto_tz(CompanyContacts::Table)
                    .col(pk_auto(CompanyContacts::Id))
                    .col(uuid_uniq(CompanyContacts::InternalId))
                    .col(string_null(CompanyContacts::ContactName))
                    .col(string_null(CompanyContacts::ContactPhoneNumber))
                    .col(string_null(CompanyContacts::ContactEmail))
                    .col(integer(CompanyContacts::CompanyId))
                    .foreign_key(
                        ForeignKey::create()
                            .name("fk-company_contacts-companies")
                            .from(CompanyContacts::Table, CompanyContacts::CompanyId)
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
            .drop_table(Table::drop().table(CompanyContacts::Table).to_owned())
            .await
    }
}

#[derive(DeriveIden)]
enum CompanyContacts {
    Table,
    Id,
    InternalId,
    ContactName,
    ContactPhoneNumber,
    ContactEmail,
    CompanyId,
    
}


#[derive(DeriveIden)]
enum Companies {
    Table,
    Id,
}
