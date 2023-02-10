import 'dart:convert';
import 'dart:io';

Config configFromJson(String str) => Config.fromJson(json.decode(str));

String configToJson(Config data) => json.encode(data.toJson());

Future<Config> loadConfig() async {
  var file = File(Config.configFilename);

  if (await file.exists()) {
    return configFromJson(await file.readAsString());
  }

  await file.create();
  await file.writeAsString(configToJson(Config.defaults()));
  print("Config not found, a default config was created.");
  print("Please configure it.");
  exit(0);
}

class Config {
  final String injectorFilename;
  final String serverFilename;
  final String apiUrl;
  static const configFilename = "sw_config.json";

  Config({
    required this.injectorFilename,
    required this.serverFilename,
    required this.apiUrl,
  });

  factory Config.defaults() => Config(
        injectorFilename: "injector.jar",
        serverFilename: "server.jar",
        apiUrl: "example.com",
      );

  factory Config.fromJson(Map<String, dynamic> json) => Config(
        injectorFilename: json["injectorFilename"],
        serverFilename: json["serverFilename"],
        apiUrl: json["apiUrl"],
      );

  Map<String, dynamic> toJson() => {
        "injectorFilename": injectorFilename,
        "serverFilename": serverFilename,
        "apiUrl": apiUrl,
      };
}
