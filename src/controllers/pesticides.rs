#![allow(clippy::missing_errors_doc)]
#![allow(clippy::unnecessary_struct_initialization)]
#![allow(clippy::unused_async)]
use loco_rs::prelude::*;
use axum::debug_handler;
use serde::{Deserialize, Serialize};
use crate::{models::_entities::pesticides::{ActiveModel, Column, Entity, Model, PesticideResponse}, utils::datetime_utils::set_updated_at};
use sea_orm::QueryOrder;

#[derive(Clone, Debug, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")] // incoming camelCase like pesticideName will be transformed to pesticide_name
pub struct Params {
    pub pesticide_name: String,
    pub pesticide_type: Option<String>,
    pub pesticide_subtypes: Vec<String>,
    // pub pesticide_subtype1: Option<String>,
    // pub pesticide_subtype2: Option<String>,
    // pub pesticide_subtype3: Option<String>,
    // pub pesticide_subtype4: Option<String>,
    pub pesticide_substance1: Option<String>,
    pub pesticide_substance2: Option<String>,
    pub pesticide_substance3: Option<String>,
    pub pesticide_substance4: Option<String>,
    pub pesticide_antidote1: Option<String>,
    pub pesticide_antidote2: Option<String>
}

impl Params {
    fn update(&self, item: &mut ActiveModel) {
        item.pesticide_name = Set(self.pesticide_name.clone());
        item.pesticide_type = Set(self.pesticide_type.clone());
        item.pesticide_subtype1 = Set(self.pesticide_subtypes.get(0).cloned());
        item.pesticide_subtype2 = Set(self.pesticide_subtypes.get(1).cloned());
        item.pesticide_subtype3 = Set(self.pesticide_subtypes.get(2).cloned());
        item.pesticide_subtype4 = Set(self.pesticide_subtypes.get(3).cloned());
        item.pesticide_substance1 = Set(self.pesticide_substance1.clone());
        item.pesticide_substance2 = Set(self.pesticide_substance2.clone());
        item.pesticide_substance3 = Set(self.pesticide_substance3.clone());
        item.pesticide_substance4 = Set(self.pesticide_substance4.clone());
        item.pesticide_antidote1 = Set(self.pesticide_antidote1.clone());
        item.pesticide_antidote2 = Set(self.pesticide_antidote2.clone());
    }
}

async fn load_item(ctx: &AppContext, internal_id: Uuid) -> Result<Model> {
    let item = Entity::find()
        .filter(Column::InternalId.eq(internal_id))  // Query by internal_id (UUID)
        .one(&ctx.db)
        .await?;
    item.ok_or_else(|| Error::NotFound)
}

// #[debug_handler]
// pub async fn list(State(ctx): State<AppContext>) -> Result<Response> {
//     format::json(
//         Entity::find()
//         .order_by_asc(Column::PesticideName)
//         .all(&ctx.db).await?)
// }

#[debug_handler]
pub async fn list(State(ctx): State<AppContext>) -> Result<Response> {
    let items = Entity::find()
        .order_by_asc(Column::PesticideName)
        .all(&ctx.db)
        .await?;
    
    // Convert each item to PesticideResponse
    let responses: Vec<PesticideResponse> = items.into_iter().map(|item| item.to_response()).collect();

    format::json(responses)
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
    
    // Use the utility function to set the updated_at field, passing the accessor
    set_updated_at(&mut item, |item| &mut item.updated_at);

    params.update(&mut item);
    let item = item.update(&ctx.db).await?;
    format::json(item)
}

#[debug_handler]
pub async fn remove(Path(internal_id): Path<Uuid>, State(ctx): State<AppContext>) -> Result<Response> {
    load_item(&ctx, internal_id).await?.delete(&ctx.db).await?;
    format::empty()
}

// #[debug_handler]
// pub async fn get_one(Path(internal_id): Path<Uuid>, State(ctx): State<AppContext>) -> Result<Response> {
//     format::json(load_item(&ctx, internal_id).await?)
// }

#[debug_handler]
pub async fn get_one(Path(internal_id): Path<Uuid>, State(ctx): State<AppContext>) -> Result<Response> {
    let item = load_item(&ctx, internal_id).await?;
    let response = item.to_response();  // Convert to PesticideResponse
    format::json(response)
}

pub fn routes() -> Routes {
    Routes::new()
        .prefix("api/pesticides")
        .add("/", get(list))
        .add("/", post(add))
        .add("/:internal_id", get(get_one))
        .add("/:internal_id", delete(remove))
        .add("/:internal_id", post(update))
}
