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
                    .col(
                        ColumnDef::new(CompanyContacts::InternalId)
                            .uuid()  // Defines it as a UUID type column
                            .not_null()
                            .unique_key()
                            .default(Expr::cust("uuid_generate_v4()")),  // PostgreSQL function to auto-generate UUID
                    )
                    .col(string_null(CompanyContacts::ContactName))
                    .col(string_null(CompanyContacts::ContactPhoneNumber))
                    .col(string_null(CompanyContacts::ContactEmail))
                    .col(
                        ColumnDef::new(CompanyContacts::CompanyIid)  // Foreign key column for internal_id
                            .uuid()  // Defines it as a UUID type
                            .not_null(),
                    )
                    .foreign_key(
                        ForeignKey::create()
                            .name("fk-company_contacts-companies")
                            .from(CompanyContacts::Table, CompanyContacts::CompanyIid)
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
    CompanyIid,
    
}


#[derive(DeriveIden)]
enum Companies {
    Table,
    InternalId,
}
