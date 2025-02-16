mod core;
use std::path::Path;

fn main() {
    println!("Aurora ServerWrapper v2.0.0");
    let config = core::config::get_config();
    println!("Configuration loaded successfully");
    if !Path::new("injector.jar").exists() {
        core::http::download_injector();
    }
    core::start::start_server(config);
}
