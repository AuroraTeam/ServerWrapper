import 'dart:io';

import 'package:serverwrapper/config.dart';

class Starter {
  static start(Config config) async {
    var process = await Process.start('java', [
      '-javaagent:${config.injectorFilename}=${config.apiUrl}',
      "-jar",
      config.serverFilename
    ]);
    stdout.addStream(process.stdout);
    stderr.addStream(process.stderr);
  }
}
