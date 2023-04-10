import 'package:expatx/core/environment/environment.dart';

class ApiEndpoints {
  static final String apiBaseUrl = Environment().config.apiBaseUrl;

  // Authentication
  static const String login = "/login";
  static const String register = "/register";
  static const String logout = "/logout";

  //Work Orders
  static String getFeedItems(int userId) => '/users/$userId/feed-posts';
}
