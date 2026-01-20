use serde::{Deserialize, Serialize};

#[derive(Serialize, Deserialize, Debug, Clone)]
pub struct CalendarEvent {
    pub id: Option<i64>,
    pub name: String,
    pub sport: String,
    pub date: String,
    pub location: Option<String>,
    pub created_at: Option<String>,
}

#[derive(Deserialize)]
pub struct CreateCalendarEvent {
    pub name: String,
    pub sport: String,
    pub date: String,
    pub location: Option<String>,
}

#[derive(Deserialize)]
pub struct UpdateCalendarEvent {
    pub name: Option<String>,
    pub sport: Option<String>,
    pub date: Option<String>,
    pub location: Option<String>,
}
