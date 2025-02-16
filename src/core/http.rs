use serde::Deserialize;
use sha2::{Digest, Sha256};
use std::fmt::Write;
use std::fs;
use ureq::config::Config;
use ureq::tls::{TlsConfig, TlsProvider};

pub fn download_injector() {
    let config_web = Config::builder()
        .tls_config(
            TlsConfig::builder()
                // requires the native-tls feature
                .provider(TlsProvider::NativeTls)
                .build(),
        )
        .build();
    let agent = config_web.new_agent();

    let body = agent
        .get("https://authlib-injector.yushi.moe/artifact/latest.json")
        .call()
        .unwrap()
        .body_mut()
        .read_json::<Artifact>()
        .unwrap();

    let file_injector = agent
        .get(&body.download_url)
        .call()
        .unwrap()
        .body_mut()
        .read_to_vec()
        .unwrap();
    fs::write("injector.jar", &file_injector).expect("Can't write to file");

    if !check_sum(&file_injector, &body.checksums.sha256) {
        fs::remove_file("injector.jar").expect("Can't remove file");
        panic!("Checksum failed");
    }
    println!("Injector downloaded successfully");
}

fn check_sum(file: &[u8], sum: &String) -> bool {
    let hash = Sha256::digest(file);
    let test = bytes_to_hex(&hash);
    return &test == sum;
}

fn bytes_to_hex(bytes: &[u8]) -> String {
    let mut hex_string = String::with_capacity(bytes.len() * 2);
    for byte in bytes {
        write!(hex_string, "{:02x}", byte).unwrap();
    }
    hex_string
}

#[derive(Deserialize)]
pub struct Artifact {
    pub download_url: String,
    pub checksums: ArtifactChecksums,
}

#[derive(Deserialize)]
pub struct ArtifactChecksums {
    pub sha256: String,
}
