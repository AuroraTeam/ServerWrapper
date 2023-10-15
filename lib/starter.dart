import 'dart:io';

import 'package:serverwrapper/config.dart';

class Starter {
  static start(Config config) {
    var args = ['-javaagent:${config.injectorFilename}=${config.apiUrl}'];

    if (config.additionalFlags.isNotEmpty) {
      args.addAll(config.additionalFlags.split(' '));
    }

    args.addAll(['-jar', config.serverFilename]);

    if (config.arguments.isNotEmpty) {
      args.addAll(config.arguments.split(' '));
    }

    Process.start(config.javaExecutablePath, args,
        mode: ProcessStartMode.inheritStdio);
  }
}
