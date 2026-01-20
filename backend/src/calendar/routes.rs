use super::models::*;
use crate::config::AppState;
use axum::{
    Json, Router,
    extract::{Path, State},
    http::StatusCode,
    routing::get,
};

// Get all calendar events
async fn get_events(
    State(state): State<AppState>,
) -> Result<Json<Vec<CalendarEvent>>, (StatusCode, String)> {
    let response = state
        .client
        .get(&state.calendar_events_url())
        .header("apikey", &state.supabase_key)
        .header("Authorization", format!("Bearer {}", state.supabase_key))
        .query(&[("select", "*"), ("order", "date.asc")])
        .send()
        .await
        .map_err(|e| {
            tracing::error!("Supabase request error: {}", e);
            (
                StatusCode::INTERNAL_SERVER_ERROR,
                "Failed to fetch events".to_string(),
            )
        })?;

    if !response.status().is_success() {
        let error_text = response.text().await.unwrap_or_default();
        tracing::error!("Supabase error: {}", error_text);
        return Err((
            StatusCode::INTERNAL_SERVER_ERROR,
            "Failed to fetch events".to_string(),
        ));
    }

    let events = response.json::<Vec<CalendarEvent>>().await.map_err(|e| {
        tracing::error!("JSON parse error: {}", e);
        (
            StatusCode::INTERNAL_SERVER_ERROR,
            "Failed to parse events".to_string(),
        )
    })?;

    Ok(Json(events))
}

// Get single calendar event
async fn get_event(
    State(state): State<AppState>,
    Path(id): Path<i64>,
) -> Result<Json<CalendarEvent>, (StatusCode, String)> {
    let response = state
        .client
        .get(&state.calendar_events_url())
        .header("apikey", &state.supabase_key)
        .header("Authorization", format!("Bearer {}", state.supabase_key))
        .query(&[("id", format!("eq.{}", id)), ("select", "*".to_string())])
        .send()
        .await
        .map_err(|e| {
            tracing::error!("Supabase request error: {}", e);
            (
                StatusCode::INTERNAL_SERVER_ERROR,
                "Failed to fetch event".to_string(),
            )
        })?;

    let mut events = response.json::<Vec<CalendarEvent>>().await.map_err(|_| {
        (
            StatusCode::INTERNAL_SERVER_ERROR,
            "Failed to parse event".to_string(),
        )
    })?;

    events
        .pop()
        .map(Json)
        .ok_or((StatusCode::NOT_FOUND, "Event not found".to_string()))
}

// Create calendar event
async fn create_event(
    State(state): State<AppState>,
    Json(payload): Json<CreateCalendarEvent>,
) -> Result<(StatusCode, Json<CalendarEvent>), (StatusCode, String)> {
    let new_event = serde_json::json!({
        "name": payload.name,
        "sport": payload.sport,
        "date": payload.date,
        "location": payload.location,
    });

    let response = state
        .client
        .post(&state.calendar_events_url())
        .header("apikey", &state.supabase_key)
        .header("Authorization", format!("Bearer {}", state.supabase_key))
        .header("Content-Type", "application/json")
        .header("Prefer", "return=representation")
        .json(&new_event)
        .send()
        .await
        .map_err(|e| {
            tracing::error!("Supabase request error: {}", e);
            (
                StatusCode::INTERNAL_SERVER_ERROR,
                "Failed to create event".to_string(),
            )
        })?;

    if !response.status().is_success() {
        let error_text = response.text().await.unwrap_or_default();
        tracing::error!("Supabase error: {}", error_text);
        return Err((
            StatusCode::INTERNAL_SERVER_ERROR,
            "Failed to create event".to_string(),
        ));
    }

    let mut events = response.json::<Vec<CalendarEvent>>().await.map_err(|_| {
        (
            StatusCode::INTERNAL_SERVER_ERROR,
            "Failed to parse created event".to_string(),
        )
    })?;

    events
        .pop()
        .map(|event| (StatusCode::CREATED, Json(event)))
        .ok_or((
            StatusCode::INTERNAL_SERVER_ERROR,
            "Failed to return created event".to_string(),
        ))
}

// Update calendar event
async fn update_event(
    State(state): State<AppState>,
    Path(id): Path<i64>,
    Json(payload): Json<UpdateCalendarEvent>,
) -> Result<Json<CalendarEvent>, (StatusCode, String)> {
    let mut update_data = serde_json::Map::new();

    if let Some(name) = payload.name {
        update_data.insert("name".to_string(), serde_json::Value::String(name));
    }
    if let Some(sport) = payload.sport {
        update_data.insert("sport".to_string(), serde_json::Value::String(sport));
    }
    if let Some(date) = payload.date {
        update_data.insert("date".to_string(), serde_json::Value::String(date));
    }
    if let Some(location) = payload.location {
        update_data.insert("location".to_string(), serde_json::Value::String(location));
    }

    let response = state
        .client
        .patch(&format!("{}?id=eq.{}", state.calendar_events_url(), id))
        .header("apikey", &state.supabase_key)
        .header("Authorization", format!("Bearer {}", state.supabase_key))
        .header("Content-Type", "application/json")
        .header("Prefer", "return=representation")
        .json(&update_data)
        .send()
        .await
        .map_err(|e| {
            tracing::error!("Supabase request error: {}", e);
            (
                StatusCode::INTERNAL_SERVER_ERROR,
                "Failed to update event".to_string(),
            )
        })?;

    let mut events = response.json::<Vec<CalendarEvent>>().await.map_err(|_| {
        (
            StatusCode::INTERNAL_SERVER_ERROR,
            "Failed to parse updated event".to_string(),
        )
    })?;

    events
        .pop()
        .map(Json)
        .ok_or((StatusCode::NOT_FOUND, "Event not found".to_string()))
}

// Delete calendar event
async fn delete_event(
    State(state): State<AppState>,
    Path(id): Path<i64>,
) -> Result<StatusCode, (StatusCode, String)> {
    let response = state
        .client
        .delete(&format!("{}?id=eq.{}", state.calendar_events_url(), id))
        .header("apikey", &state.supabase_key)
        .header("Authorization", format!("Bearer {}", state.supabase_key))
        .send()
        .await
        .map_err(|e| {
            tracing::error!("Supabase request error: {}", e);
            (
                StatusCode::INTERNAL_SERVER_ERROR,
                "Failed to delete event".to_string(),
            )
        })?;

    if response.status().is_success() {
        Ok(StatusCode::NO_CONTENT)
    } else {
        Err((
            StatusCode::INTERNAL_SERVER_ERROR,
            "Failed to delete event".to_string(),
        ))
    }
}

// Build calendar routes
pub fn routes() -> Router<AppState> {
    Router::new()
        .route("/calendar/events", get(get_events).post(create_event))
        .route(
            "/calendar/events/:id",
            get(get_event).patch(update_event).delete(delete_event),
        )
}
