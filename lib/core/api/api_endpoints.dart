import 'package:netigo_front/core/environment/environment.dart';

class ApiEndpoints {
  static final String apiBaseUrl = Environment().config.apiBaseUrl;

  // Authentication
  static const String login = "/login";
  static const String register = "/signup";
  static const String logout = "/logout";
}
