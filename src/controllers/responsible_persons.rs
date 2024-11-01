#![allow(clippy::missing_errors_doc)]
#![allow(clippy::unnecessary_struct_initialization)]
#![allow(clippy::unused_async)]
use loco_rs::prelude::*;
use axum::debug_handler;
use serde::{Deserialize, Serialize};
use crate::{models::_entities::responsible_persons::{ActiveModel, Column, Entity, Model}, utils::datetime_utils::set_updated_at};
use sea_orm::QueryOrder;

#[derive(Clone, Debug, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")] // incoming camelCase like responsiblePersonName will be transformed to responsible_person_name
pub struct Params {
    pub responsible_person_name: Option<String>,
    pub responsible_person_license: String
}

impl Params {
    fn update(&self, item: &mut ActiveModel) {
        item.responsible_person_name = Set(self.responsible_person_name.clone());
        item.responsible_person_license = Set(self.responsible_person_license.clone());
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
    format::json(
        Entity::find()
        .order_by_asc(Column::ResponsiblePersonName)
        .all(&ctx.db).await?)
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

#[debug_handler]
pub async fn get_one(Path(internal_id): Path<Uuid>, State(ctx): State<AppContext>) -> Result<Response> {
    format::json(load_item(&ctx, internal_id).await?)
}

pub fn routes() -> Routes {
    Routes::new()
        .prefix("api/responsible_persons")
        .add("/", get(list))
        .add("/", post(add))
        .add("/:internal_id", get(get_one))
        .add("/:internal_id", delete(remove))
        .add("/:internal_id", post(update))
}
