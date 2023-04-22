import 'package:expatx/features/tabs/feed/domain/entities/feed_post_entity.dart';

import 'feed_post_comment_model.dart';

class FeedPostModel extends FeedPostEntity {
  const FeedPostModel({
    required super.id,
    required super.content,
    required super.language,
    required super.userId,
    required super.createdAt,
    required super.comments,
  });

  factory FeedPostModel.fromJson(Map<String, dynamic> json) => FeedPostModel(
        id: json["id"],
        content: json["content"],
        language: json["language"],
        userId: json["user_id"],
        createdAt: json["created_at"],
        comments: json["comments"] == null
            ? null
            : List<FeedPostCommentModel>.from(
                json["comments"].map((x) => FeedPostCommentModel.fromJson(x))),
      );

  FeedPostEntity toEntity() => FeedPostEntity(
        id: id,
        content: content,
        language: language,
        userId: userId,
        createdAt: createdAt,
        comments: comments,
      );
}
