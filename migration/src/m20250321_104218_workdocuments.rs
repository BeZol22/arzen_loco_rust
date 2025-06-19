use loco_rs::schema::table_auto_tz;
use sea_orm_migration::{prelude::*, schema::*};

#[derive(DeriveMigrationName)]
pub struct Migration;

#[async_trait::async_trait]
impl MigrationTrait for Migration {
    async fn up(&self, manager: &SchemaManager) -> Result<(), DbErr> {
        manager
            .create_table(
                table_auto_tz(Workdocuments::Table)
                    .col(pk_auto(Workdocuments::Id))
                    .col(
                        ColumnDef::new(Workdocuments::InternalId)
                            .uuid()  // Defines it as a UUID type column
                            .not_null()
                            .unique_key()
                            .default(Expr::cust("uuid_generate_v4()")),  // PostgreSQL function to auto-generate UUID
                    )
                    .col(string_uniq(Workdocuments::SerialNumber))
                    .col(string_null(Workdocuments::ClientName))
                    .col(string_null(Workdocuments::JobsDone))
                    .col(json_binary_null(Workdocuments::Pesticides))
                    .col(json_binary_null(Workdocuments::ResponsiblePerson))
                    .col(string_null(Workdocuments::ClientNameForWorkPaper))
                    .col(string_null(Workdocuments::ScopeOfWork))
                    .col(json_binary_null(Workdocuments::WorkArt))
                    // .col(timestamp_with_time_zone_null(Workdocuments::WorkEndDate))
                    .col(timestamp_with_time_zone_null(Workdocuments::WorkStartDate))
                    .col(json_binary_null(Workdocuments::WorkSubject))
                    .col(string_null(Workdocuments::WorkSubjectOther))
                    .col(integer(Workdocuments::CompanyId))
                    .foreign_key(
                        ForeignKey::create()
                            .name("fk-workdocuments-companies")
                            .from(Workdocuments::Table, Workdocuments::CompanyId)
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
            .drop_table(Table::drop().table(Workdocuments::Table).to_owned())
            .await
    }
}

#[derive(DeriveIden)]
enum Workdocuments {
    Table,
    Id,
    InternalId,
    SerialNumber,
    ClientName,
    JobsDone,
    Pesticides,
    ResponsiblePerson,
    ClientNameForWorkPaper,
    ScopeOfWork,
    WorkArt,
    // WorkEndDate,
    WorkStartDate,
    WorkSubject,
    WorkSubjectOther,
    CompanyId
}


#[derive(DeriveIden)]
enum Companies {
    Table,
    Id,
}
