use reqwest::Client;

#[derive(Clone)]
pub struct AppState {
    pub supabase_url: String,
    pub supabase_key: String,
    pub client: Client,
}

impl AppState {
    pub fn new(supabase_url: String, supabase_key: String) -> Self {
        Self {
            supabase_url,
            supabase_key,
            client: Client::new(),
        }
    }

    pub fn calendar_events_url(&self) -> String {
        format!("{}/rest/v1/calendar_events", self.supabase_url)
    }
}

pub fn load_config() -> (String, String) {
    dotenv::dotenv().ok();

    let supabase_url =
        std::env::var("SUPABASE_URL").expect("SUPABASE_URL must be set in .env file");
    let supabase_key =
        std::env::var("SUPABASE_ANON_KEY").expect("SUPABASE_ANON_KEY must be set in .env file");

    (supabase_url, supabase_key)
}
