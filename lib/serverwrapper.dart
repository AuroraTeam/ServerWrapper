import 'package:serverwrapper/injector.dart';
import 'package:serverwrapper/config.dart';
import 'package:serverwrapper/starter.dart';

class ServerWrapper {
  static init(List<String> arguments) async {
    print('Aurora ServerWrapper v0.1.0');

    var config = await loadConfig();
    print("Configuration loaded successfully");

    await Injector.init(config.injectorFilename);

    Starter.start(config);
  }
}
