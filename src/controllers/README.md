Documentation: https://loco.rs/docs/the-app/controller/

1. ### Controller for Companies table: ###

# Command: #

0. (To know what options are available: cargo loco generate controller --help)
1. cargo loco generate controller companies --api
2. change prefix inside controllers/companies.rs to start with api and remove "/" from the end of companies
3. Quick test: cargo loco routes