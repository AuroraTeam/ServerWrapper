import 'dart:io';
import 'package:crypto/crypto.dart';
import 'package:http/http.dart';
import 'package:serverwrapper/api_response.dart';

class Injector {
  static final apiUrl =
      Uri.parse('https://authlib-injector.yushi.moe/artifact/latest.json');

  static Future<void> init(String filename) async {
    var file = File(filename);
    if (!await file.exists()) {
      await download(file);
    } else {
      print("Injector loaded successfully");
    }
  }

  static Future<void> download(File file) async {
    var response = await get(apiUrl);
    ApiResponse parsedResponse;

    if (response.statusCode == 200) {
      parsedResponse = apiResponseFromJson(response.body);
    } else {
      print('Failed to check Authlib Injector API');
      exit(1);
    }

    var fileResponse = await get(Uri.parse(parsedResponse.downloadUrl));
    await file.writeAsBytes(fileResponse.bodyBytes);

    var bytes = await file.readAsBytes();
    var digest = sha256.convert(bytes);

    if (digest.toString() == parsedResponse.checksums.sha256) {
      print('Injector downloaded successfully');
    } else {
      print("Failed to verify checksum");
      exit(2);
    }
  }
}
