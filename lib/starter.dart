import 'dart:io';

import 'package:serverwrapper/config.dart';

class Starter {
  static start(Config config) {
    Process.start(
        config.javaExecutablePath,
        [
          '-javaagent:${config.injectorFilename}=${config.apiUrl}',
          ...config.additionalFlags.split(' '),
          "-jar",
          config.serverFilename,
          ...config.arguments.split(' '),
        ],
        mode: ProcessStartMode.inheritStdio);
  }
}
