import 'package:netigo_front/core/environment/configurations.dart/dev_config.dart';
import 'package:netigo_front/core/environment/configurations.dart/local_config.dart';

import 'configurations.dart/base_config.dart';
import 'configurations.dart/prod_config.dart';

class Environment {
  factory Environment() {
    return _singleton;
  }

  Environment._internal();

  static final Environment _singleton = Environment._internal();

  static const String local = 'LOCAL';
  static const String dev = 'DEV';
  static const String prod = 'PROD';

  late BaseConfig config;

  initConfig(String environment) {
    config = _getConfig(environment);
  }

  BaseConfig _getConfig(String environment) {
    switch (environment) {
      case Environment.dev:
        return DevConfig();
      case Environment.prod:
        return ProdConfig();
      default:
        return LocalConfig();
    }
  }
}
