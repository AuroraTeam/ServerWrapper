import 'dart:io';
import 'package:crypto/crypto.dart';
import 'package:http/http.dart';
import 'package:serverwrapper/api_response.dart';

class Injector {
  static final apiUrl =
      Uri.https('authlib-injector.yushi.moe', '/artifact/latest.json');

  static Future<void> init(String filename) async {
    var file = File(filename);
    if (!await file.exists()) {
      await _download(file);
    }
    print("Injector loaded successfully");
  }

  static Future<void> _download(File file) async {
    ApiResponse parsedResponse;
    try {
      var response = await get(apiUrl);
      if (response.statusCode != 200) {
        throw Exception('Bad status code ${response.statusCode}');
      }
      parsedResponse = parseApiResponseFromJson(response.body);
    } on Exception catch (e) {
      print('Failed to check Authlib Injector API');
      print(e);
      exit(1);
    }

    try {
      var fileResponse = await get(parsedResponse.downloadUrl);
      await file.writeAsBytes(fileResponse.bodyBytes);
    } catch (e) {
      print('Failed to download Authlib Injector');
      exit(2);
    }

    var bytes = await file.readAsBytes();
    var digest = sha256.convert(bytes).toString();

    if (digest != parsedResponse.checksums.sha256) {
      print("Authlib checksum mismatch");
      exit(3);
    }
    print('Injector downloaded successfully');
  }
}
