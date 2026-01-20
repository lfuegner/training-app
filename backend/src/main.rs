mod calendar;
mod config; // This loads the calendar/ directory

use axum::{Json, Router, routing::get};
use config::{AppState, load_config};
use serde::Serialize;
use std::net::SocketAddr;

#[derive(Serialize)]
struct HealthCheck {
    status: String,
    version: String,
}

async fn health_check() -> Json<HealthCheck> {
    Json(HealthCheck {
        status: "healthy".to_string(),
        version: env!("CARGO_PKG_VERSION").to_string(),
    })
}

#[tokio::main]
async fn main() {
    // Initialize tracing
    tracing_subscriber::fmt::init();

    // Load configuration
    let (supabase_url, supabase_key) = load_config();
    tracing::info!("Supabase URL: {}", supabase_url);

    // Create application state
    let state = AppState::new(supabase_url, supabase_key);

    // Build application with routes
    let app = Router::new()
        .route("/health", get(health_check))
        .merge(calendar::routes()) // Add calendar routes
        .with_state(state);

    // Start server
    let addr = SocketAddr::from(([0, 0, 0, 0], 3000));
    tracing::info!("🚀 Server listening on {}", addr);

    let listener = tokio::net::TcpListener::bind(addr).await.unwrap();
    axum::serve(listener, app).await.unwrap();
}
