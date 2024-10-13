#![allow(clippy::missing_errors_doc)]
#![allow(clippy::unnecessary_struct_initialization)]
#![allow(clippy::unused_async)]
use loco_rs::prelude::*;
use axum::debug_handler;
use serde::{Deserialize, Serialize};
use crate::models::_entities::company_billings::{ActiveModel, Entity, Model, Column};

#[derive(Clone, Debug, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")] // incoming camelCase like companyName will be transformed to company_name
pub struct Params {
    pub billing_company_name: String,
    pub billing_tax_number: String,
    pub billing_email: Option<String>,
    pub billing_country: Option<String>,
    pub billing_province: Option<String>,
    pub billing_postal_code: Option<String>,
    pub billing_settlement: Option<String>,
    pub billing_street: Option<String>,
    pub billing_street_number: Option<String>,
    pub company_iid: Uuid,
}

impl Params {
    fn update(&self, item: &mut ActiveModel) {
        item.billing_company_name = Set(self.billing_company_name.clone());
        item.billing_tax_number = Set(self.billing_tax_number.clone());
        item.billing_email = Set(self.billing_email.clone());
        item.billing_country = Set(self.billing_country.clone());
        item.billing_province = Set(self.billing_province.clone());
        item.billing_postal_code = Set(self.billing_postal_code.clone());
        item.billing_settlement = Set(self.billing_settlement.clone());
        item.billing_street = Set(self.billing_street.clone());
        item.billing_street_number = Set(self.billing_street_number.clone());
        item.company_iid = Set(self.company_iid.clone());
    }
}

async fn load_item(ctx: &AppContext, internal_id: Uuid) -> Result<Model> {
    let item = Entity::find()
        .filter(Column::InternalId.eq(internal_id))  // Query by internal_id (UUID)
        .one(&ctx.db)
        .await?;
    item.ok_or_else(|| Error::NotFound)
}

#[debug_handler]
pub async fn list(State(ctx): State<AppContext>) -> Result<Response> {
    format::json(Entity::find().all(&ctx.db).await?)
}

#[debug_handler]
pub async fn add(State(ctx): State<AppContext>, Json(params): Json<Params>) -> Result<Response> {
    let mut item = ActiveModel {
        ..Default::default()
    };
    params.update(&mut item);
    let item = item.insert(&ctx.db).await?;
    format::json(item)
}

#[debug_handler]
pub async fn update(
    Path(internal_id): Path<Uuid>,
    State(ctx): State<AppContext>,
    Json(params): Json<Params>,
) -> Result<Response> {
    let item = load_item(&ctx, internal_id).await?;
    let mut item = item.into_active_model();
    params.update(&mut item);
    let item = item.update(&ctx.db).await?;
    format::json(item)
}

#[debug_handler]
pub async fn remove(Path(internal_id): Path<Uuid>, State(ctx): State<AppContext>) -> Result<Response> {
    load_item(&ctx, internal_id).await?.delete(&ctx.db).await?;
    format::empty()
}

#[debug_handler]
pub async fn get_one(Path(internal_id): Path<Uuid>, State(ctx): State<AppContext>) -> Result<Response> {
    format::json(load_item(&ctx, internal_id).await?)
}

pub fn routes() -> Routes {
    Routes::new()
        .prefix("api/company_billings")
        .add("/", get(list))
        .add("/", post(add))
        .add("/:internal_id", get(get_one))
        .add("/:internal_id", delete(remove))
        .add("/:internal_id", post(update))
}

