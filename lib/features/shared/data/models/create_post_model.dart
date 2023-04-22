class CreatePostModel {
  final String content;
  final String language;
  final int userId;

  CreatePostModel({
    required this.content,
    required this.language,
    required this.userId,
  });

  Map<String, dynamic> toJson() {
    return {
      'feed_post': {
        'content': content,
        'language': language,
        'user_id': userId,
      }
    };
  }
}
