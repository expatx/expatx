import 'package:expatx/features/shared/data/models/user_model.dart';
import 'package:expatx/features/tabs/feed/domain/entities/feed_post_like_entity.dart';

class FeedPostLikeModel extends FeedPostLikeEntity {
  const FeedPostLikeModel({
    required super.id,
    required super.feedPostId,
    required super.createdAt,
    required super.user,
  });

  factory FeedPostLikeModel.fromJson(Map<String, dynamic> json) =>
      FeedPostLikeModel(
        id: json["id"],
        feedPostId: json["feed_post_id"],
        createdAt: json["created_at"],
        user: UserModel.fromJson(json["user"]).toEntity(),
      );

  FeedPostLikeEntity toEntity() => FeedPostLikeEntity(
        id: id,
        feedPostId: feedPostId,
        createdAt: createdAt,
        user: user,
      );
}
