use serde::{Deserialize, Serialize};
use serde_json;
use std::fs;

pub fn get_config() -> Settings {
    let config = {
        let res = fs::read_to_string("sw_config.json");
        let s = match res {
            Ok(s) => s,
            Err(..) => {
                let config: Settings = Settings {
                    javaExecutablePath: String::from("java"),
                    additionalFlags: String::from(""),
                    arguments: String::from(""),
                    injectorFilename: String::from("injector.jar"),
                    serverFilename: String::from("server.jar"),
                    apiUrl: String::from("example.com"),
                };
                fs::write(
                    "sw_config.json",
                    serde_json::to_string_pretty(&config).unwrap(),
                )
                .expect("Can't write to file");
                panic!("Config not found, a default config was created. \nPlease configure it.");
            }
        };
        serde_json::from_str::<Settings>(&s).unwrap()
    };

    return config;
}

#[derive(Deserialize, Serialize)]
#[allow(non_snake_case)]
pub struct Settings {
    pub javaExecutablePath: String,
    pub additionalFlags: String,
    pub arguments: String,
    pub injectorFilename: String,
    pub serverFilename: String,
    pub apiUrl: String,
}
