import 'package:expatx/core/environment/configurations.dart/base_config.dart';

class LocalConfig implements BaseConfig {
  @override
  String get apiBaseUrl => 'http://127.0.0.1:3000';
}
