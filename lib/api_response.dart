import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
part 'api_response.g.dart';

ApiResponse parseApiResponseFromJson(String str) =>
    ApiResponse.fromJson(json.decode(str));

@JsonSerializable(fieldRename: FieldRename.snake)
class ApiResponse {
  final int buildNumber;
  final String version;
  final Uri downloadUrl;
  final Checksums checksums;

  ApiResponse({
    required this.buildNumber,
    required this.version,
    required this.downloadUrl,
    required this.checksums,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) =>
      _$ApiResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ApiResponseToJson(this);
}

@JsonSerializable()
class Checksums {
  final String sha256;

  Checksums({
    required this.sha256,
  });

  factory Checksums.fromJson(Map<String, dynamic> json) =>
      _$ChecksumsFromJson(json);

  Map<String, dynamic> toJson() => _$ChecksumsToJson(this);
}
