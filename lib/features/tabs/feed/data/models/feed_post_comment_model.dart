import 'package:expatx/features/shared/data/models/user_model.dart';
import 'package:expatx/features/tabs/feed/domain/entities/feed_post_comment_entity.dart';

class FeedPostCommentModel extends FeedPostCommentEntity {
  const FeedPostCommentModel({
    required super.id,
    required super.comment,
    required super.feedPostId,
    required super.user,
    required super.createdAt,
  });

  factory FeedPostCommentModel.fromJson(Map<String, dynamic> json) =>
      FeedPostCommentModel(
        id: json["id"],
        comment: json["comment"],
        feedPostId: json["feed_post_id"],
        createdAt: json["created_at"],
         user: UserModel.fromJson(json["user"]).toEntity(),
      );

  FeedPostCommentEntity toEntity() => FeedPostCommentEntity(
        id: id,
        comment: comment,
        feedPostId: feedPostId,
        user: user,
        createdAt: createdAt,
      );
}