import 'base_config.dart';

class ProdConfig implements BaseConfig {
  @override
  String get apiBaseUrl => 'http://ourProdUrl.com';
}