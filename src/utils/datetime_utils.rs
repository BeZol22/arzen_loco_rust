use chrono::{DateTime, Utc, FixedOffset};
use sea_orm::{ActiveModelTrait, ActiveValue};
use sea_orm::entity::prelude::*;

// Utility function to set the updated_at field in an ActiveModel
pub fn set_updated_at<M, F>(item: &mut M, field: F)
where
    M: ActiveModelTrait,  // Ensure we're working with a SeaORM ActiveModel
    F: Fn(&mut M) -> &mut ActiveValue<DateTimeWithTimeZone>, // Accessor for the updated_at field
{
    let current_time_utc: DateTime<Utc> = Utc::now();
    let fixed_offset = FixedOffset::east_opt(0).unwrap(); // UTC offset
    let current_time_with_offset = current_time_utc.with_timezone(&fixed_offset);

    // Use the provided accessor to set the updated_at field
    *field(item) = ActiveValue::Set(current_time_with_offset);
}
