use super::config::Settings;
use std::process::Command;

pub fn start_server(config: Settings) {
    // Собираем аргументы для запуска сервера
    let javaagent = format!("-javaagent:{}={}", config.injectorFilename, config.apiUrl);
    let mut arg = vec![javaagent.as_str()];
    if config.additionalFlags != "" {
        let mut test = config.additionalFlags.split(" ").collect();
        arg.append(&mut test);
    }
    arg.push("-jar");
    arg.push(config.serverFilename.as_str());
    if config.arguments != "" {
        let mut test = config.arguments.split(" ").collect();
        arg.append(&mut test);
    }

    // Запускаем сервер
    let mut the_process = Command::new(config.javaExecutablePath)
        .args(arg)
        .spawn()
        .expect("Failed to execute.");
    let _ = the_process.wait();
}
