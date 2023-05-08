import 'package:expatx/core/environment/environment.dart';

class ApiEndpoints {
  static final String apiBaseUrl = Environment().config.apiBaseUrl;

  // Authentication
  static const String login = "/login";
  static const String register = "/register";
  static const String logout = "/logout";

  //Feed Posts
  static String feedPosts = '/feed-posts';

  //Feed Post Comments
  static String feedPostComments = '/feed_post_comments';

  //Feed Post Likes
  static String feedPostLikes = '/feed_post_likes';
  static String feedPostUnlike = '/unlike';
}
