1. ### Companies table generation: ###

- Internal Id as UUID
- Company Name and Tax Number are unique
- Postal Code and Street Number could be string, that's why not int

# Command: #
1. cargo loco generate model companies internal_id:uuid company_name:string^ company_tax_number:string^ company_country:string company_province:string company_postal_code:string company_settlement:string company_street:string company_street_number:string company_email:string company_phone_number:string
2. cargo loco db migrate
3. cargo loco db entities (this was done automatically by step 2)



2. ### Company-Contacts table generation: ###

- One company can have many contacts (One to many), contacts can have only one company (Many to one)
- company:references --> the reference table is the "companies" table, but we have to use singular "company" here

# Command: #
1. cargo loco generate model company_contacts internal_id:uuid contact_name:string contact_phone_number:string contact_email:string company:references
2. cargo loco db migrate
3. cargo loco db entities (this was done automatically by step 2)