import 'dart:convert';

ApiResponse apiResponseFromJson(String str) =>
    ApiResponse.fromJson(json.decode(str));

class ApiResponse {
  final int buildNumber;
  final String version;
  final String downloadUrl;
  final Checksums checksums;

  ApiResponse({
    required this.buildNumber,
    required this.version,
    required this.downloadUrl,
    required this.checksums,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) => ApiResponse(
        buildNumber: json["build_number"],
        version: json["version"],
        downloadUrl: json["download_url"],
        checksums: Checksums.fromJson(json["checksums"]),
      );
}

class Checksums {
  Checksums({
    required this.sha256,
  });

  final String sha256;

  factory Checksums.fromJson(Map<String, dynamic> json) => Checksums(
        sha256: json["sha256"],
      );
}
