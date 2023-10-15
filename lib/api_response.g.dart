// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiResponse _$ApiResponseFromJson(Map<String, dynamic> json) => ApiResponse(
      buildNumber: json['build_number'] as int,
      version: json['version'] as String,
      downloadUrl: Uri.parse(json['download_url'] as String),
      checksums: Checksums.fromJson(json['checksums'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ApiResponseToJson(ApiResponse instance) =>
    <String, dynamic>{
      'build_number': instance.buildNumber,
      'version': instance.version,
      'download_url': instance.downloadUrl.toString(),
      'checksums': instance.checksums,
    };

Checksums _$ChecksumsFromJson(Map<String, dynamic> json) => Checksums(
      sha256: json['sha256'] as String,
    );

Map<String, dynamic> _$ChecksumsToJson(Checksums instance) => <String, dynamic>{
      'sha256': instance.sha256,
    };
