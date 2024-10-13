Documentation: https://loco.rs/docs/the-app/models/

0. Inside PostgreSql enable UUID-generation: CREATE EXTENSION IF NOT EXISTS "uuid-ossp"; /need to add it to docker file?/

1. ### Companies table generation: ###

- Internal Id as UUID
- Company Name and Tax Number are unique (-> string^)
- Postal Code and Street Number could be string, that's why not int

# Command: #

1. cargo loco generate model companies internal_id:uuid company_name:string^ company_tax_number:string^ company_country:string company_province:string company_postal_code:string company_settlement:string company_street:string company_street_number:string company_email:string company_phone_number:string
2. cargo loco db migrate
3. cargo loco db entities (this was done automatically by step 2)



2. ### Company-Contacts table generation: ###

- Internal Id as UUID
- One company can have many contacts (One to many), contacts can have only one company (Many to one)
- company:references --> the reference table is the "companies" table, but we have to use singular "company" here

# Command: #

1. cargo loco generate model company_contacts internal_id:uuid contact_name:string contact_phone_number:string contact_email:string company:references
2. cargo loco db migrate
3. cargo loco db entities (this was done automatically by step 2)
4. Inside migration file UUID field and reference fields has to be changed:

For example

from: .col(uuid_uniq(CompanyContacts::InternalId))
to: .col(
            ColumnDef::new(CompanyContacts::InternalId)
                .uuid()  // Defines it as a UUID type column
                .not_null()
                .unique_key()
                .default(Expr::cust("uuid_generate_v4()")),  // PostgreSQL function to auto-generate UUID
        )

AND

from: .col(integer(CompanyContacts::CompanyId))
        .foreign_key(
            ForeignKey::create()
                .name("fk-company_premises-companies")
                .from(CompanyContacts::Table, CompanyContacts::CompanyId)
                .to(Companies::Table, Companies::Id)
                .on_delete(ForeignKeyAction::Cascade)
                .on_update(ForeignKeyAction::Cascade),
        )
to: .col(
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



3. ### Company-Billings table generation: ###

- Internal Id as UUID
- Billing Company Name and Billing Tax Number are unique (-> string^)
- One company can have many billings (One to many), billing can have only one company (Many to one)
- company:references --> the reference table is the "companies" table, but we have to use singular "company" here

# Command: #

1. cargo loco generate model company_billings internal_id:uuid billing_company_name:string^ billing_tax_number:string^ billing_email:string billing_country:string billing_province:string billing_postal_code:string billing_settlement:string billing_street:string billing_street_number:string company:references
2. cargo loco db migrate
3. cargo loco db entities (this was done automatically by step 2)



4. ### Company-Premises table generation: ###

- Internal Id as UUID
- One company can have many premises (One to many), premises can have only one company (Many to one)
- company:references --> the reference table is the "companies" table, but we have to use singular "company" here

# Command: #

1. cargo loco generate model company_premises internal_id:uuid premise_company_name:string premise_country:string premise_email:string premise_phone_number:string premise_postal_code:string premise_province:string premise_settlement:string premise_street:string premise_street_number:string company:references
2. cargo loco db migrate
3. cargo loco db entities (this was done automatically by step 2)