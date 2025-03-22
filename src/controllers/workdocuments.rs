#![allow(clippy::missing_errors_doc)]
#![allow(clippy::unnecessary_struct_initialization)]
#![allow(clippy::unused_async)]
use loco_rs::prelude::*;
use axum::debug_handler;
use serde::{Deserialize, Serialize};
use crate::{models::_entities::workdocuments::{ActiveModel, Column, Entity, Model}, utils::datetime_utils::set_updated_at};
use sea_orm::{QueryOrder, QuerySelect};
use serde_json::Value;
use chrono::{DateTime, FixedOffset, Local};
use futures::future::try_join_all;

#[derive(Clone, Debug, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")] // incoming camelCase like serialNumber will be transformed to serial_number
pub struct Params {
    #[serde(skip_deserializing)] // Skip incoming value entirely
    pub serial_number: String,
    pub client_name: Option<String>,
    pub jobs_done: Option<String>,
    pub pesticides: Option<Value>,
    pub responsible_person: Option<Value>,
    pub client_name_for_work_paper: Option<String>,
    pub scope_of_work: Option<String>,
    pub work_art: Option<Value>,
    pub work_end_date: Option<DateTime<FixedOffset>>,
    pub work_start_date: Option<DateTime<FixedOffset>>,
    pub work_subject: Option<Value>,
    pub work_subject_other: Option<String>,
    #[serde(rename = "companyId")]
    pub company_internal_id: Uuid,
}

impl Params {
    fn update(&self, item: &mut ActiveModel) {
        // item.serial_number = Set(self.serial_number.clone());
        item.client_name = Set(self.client_name.clone());
        item.jobs_done = Set(self.jobs_done.clone());
        item.pesticides = Set(self.pesticides.clone());
        item.responsible_person = Set(self.responsible_person.clone());
        item.client_name_for_work_paper = Set(self.client_name_for_work_paper.clone());
        item.scope_of_work = Set(self.scope_of_work.clone());
        item.work_art = Set(self.work_art.clone());
        item.work_end_date = Set(self.work_end_date.clone());
        item.work_start_date = Set(self.work_start_date.clone());
        item.work_subject = Set(self.work_subject.clone());
        item.work_subject_other = Set(self.work_subject_other.clone());
        // item.company_internal_id = Set(self.company_internal_id.clone());
    }
}

#[derive(Serialize)]
#[serde(rename_all = "camelCase")]
pub struct WorkdocumentResponse {
    pub internal_id: Uuid,
    pub serial_number: String,
    pub client_name: Option<String>,
    pub jobs_done: Option<String>,
    pub pesticides: Option<Value>,
    pub responsible_person: Option<Value>,
    pub client_name_for_work_paper: Option<String>,
    pub scope_of_work: Option<String>,
    pub work_art: Option<Value>,
    pub work_end_date: Option<DateTime<FixedOffset>>,
    pub work_start_date: Option<DateTime<FixedOffset>>,
    pub work_subject: Option<Value>,
    pub work_subject_other: Option<String>,
    #[serde(rename = "companyId")]
    pub company_id: Uuid,
    pub created_at: DateTimeWithTimeZone,
    pub updated_at: DateTimeWithTimeZone,
}

impl WorkdocumentResponse {
    pub fn from_model(model: Model, company_internal_id: Uuid) -> Self {
        Self {
            internal_id: model.internal_id,
            serial_number: model.serial_number,
            client_name: model.client_name,
            jobs_done: model.jobs_done,
            pesticides: model.pesticides,
            responsible_person: model.responsible_person,
            client_name_for_work_paper: model.client_name_for_work_paper,
            scope_of_work: model.scope_of_work,
            work_art: model.work_art,
            work_end_date: model.work_end_date.map(|dt| dt.into()),
            work_start_date: model.work_start_date.map(|dt| dt.into()),
            work_subject: model.work_subject,
            work_subject_other: model.work_subject_other,
            company_id: company_internal_id,
            created_at: model.created_at,
            updated_at: model.updated_at,
        }
    }
}

async fn generate_serial_number(db: &DatabaseConnection) -> Result<String> {
    let today = Local::now().format("%Y%m%d").to_string(); // e.g., "20250328"

    // Look for the highest serial_number for today
    use crate::models::_entities::workdocuments;
    let last_serial: Option<String> = workdocuments::Entity::find()
        .filter(workdocuments::Column::SerialNumber.like(format!("{}%", today)))
        .order_by_desc(workdocuments::Column::SerialNumber)
        .limit(1)
        .one(db)
        .await?
        .map(|model| model.serial_number);

    let next_seq = match last_serial {
        Some(serial) => serial[8..].parse::<u32>().unwrap_or(0) + 1,
        None => 1,
    };

    let serial_number = format!("{}{:04}", today, next_seq); // e.g., "202503280001"
    Ok(serial_number)
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
    let items = Entity::find()
        .order_by_asc(Column::WorkStartDate)
        .all(&ctx.db)
        .await?;

    let responses = try_join_all(items.into_iter().map(|item| {
        let ctx = ctx.clone();
        async move {
            let company = crate::controllers::companies::load_by_id(&ctx, item.company_id).await?;
            Ok::<_, Error>(WorkdocumentResponse::from_model(item, company.internal_id))
        }
    }))
    .await?;

    format::json(responses)
}

#[debug_handler]
pub async fn add(State(ctx): State<AppContext>, Json(params): Json<Params>) -> Result<Response> {
    let company = crate::controllers::companies::load_item(&ctx, params.company_internal_id).await?;
    let serial_number = generate_serial_number(&ctx.db).await?;

    let mut item = ActiveModel {
        company_id: Set(company.id),
        serial_number: Set(serial_number),
        ..Default::default()
    };

    params.update(&mut item);
    let item = item.insert(&ctx.db).await?;
    let company_internal_id = company.internal_id;
    let response = WorkdocumentResponse::from_model(item, company_internal_id);
    format::json(response)
}

#[debug_handler]
pub async fn update(
    Path(internal_id): Path<Uuid>,
    State(ctx): State<AppContext>,
    Json(params): Json<Params>,
) -> Result<Response> {
    // 1. Load the existing workdocument by internal_id
    let item = load_item(&ctx, internal_id).await?;
    let mut item = item.into_active_model();

    // 2. Resolve the actual company_id from company_internal_id
    let company = crate::controllers::companies::load_item(&ctx, params.company_internal_id).await?;
    item.company_id = Set(company.id); // Set correct foreign key

    // 3. Update the other fields
    set_updated_at(&mut item, |item| &mut item.updated_at);
    params.update(&mut item);

    // 4. Update the database record
    let item = item.update(&ctx.db).await?;
    let company_internal_id = company.internal_id;
    let response = WorkdocumentResponse::from_model(item, company_internal_id);
    format::json(response)
}

pub async fn load_by_id(ctx: &AppContext, id: i32) -> Result<Model> {
    let item = Entity::find_by_id(id).one(&ctx.db).await?;
    item.ok_or_else(|| Error::NotFound)
}

#[debug_handler]
pub async fn get_one(
    Path(internal_id): Path<Uuid>,
    State(ctx): State<AppContext>,
) -> Result<Response> {
    let item = load_item(&ctx, internal_id).await?;
    
    // Load the related company using the internal `company_id` (i32)
    let company = crate::controllers::companies::load_by_id(&ctx, item.company_id).await?;
    
    let response = WorkdocumentResponse::from_model(item, company.internal_id);
    format::json(response)
}

#[debug_handler]
pub async fn remove(Path(internal_id): Path<Uuid>, State(ctx): State<AppContext>) -> Result<Response> {
    load_item(&ctx, internal_id).await?.delete(&ctx.db).await?;
    format::empty()
}

pub fn routes() -> Routes {
    Routes::new()
        .prefix("api/workdocuments")
        .add("/", get(list))
        .add("/", post(add))
        .add("/:internal_id", get(get_one))
        .add("/:internal_id", delete(remove))
        .add("/:internal_id", post(update))
}
