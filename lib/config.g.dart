// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Config _$ConfigFromJson(Map<String, dynamic> json) => Config(
      javaExecutablePath: json['javaExecutablePath'] as String,
      additionalFlags: json['additionalFlags'] as String,
      arguments: json['arguments'] as String,
      injectorFilename: json['injectorFilename'] as String,
      serverFilename: json['serverFilename'] as String,
      apiUrl: json['apiUrl'] as String,
    );

Map<String, dynamic> _$ConfigToJson(Config instance) => <String, dynamic>{
      'javaExecutablePath': instance.javaExecutablePath,
      'additionalFlags': instance.additionalFlags,
      'arguments': instance.arguments,
      'injectorFilename': instance.injectorFilename,
      'serverFilename': instance.serverFilename,
      'apiUrl': instance.apiUrl,
    };
