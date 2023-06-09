import 'package:equatable/equatable.dart';
import 'package:expatx/features/shared/domain/entities/user_entity.dart';
import 'package:expatx/features/tabs/feed/domain/entities/feed_post_comment_entity.dart';

import 'feed_post_like_entity.dart';

class FeedPostEntity extends Equatable {
  const FeedPostEntity({
    required this.id,
    required this.content,
    required this.language,
    required this.userEntity,
    required this.createdAt,
    required this.comments,
    required this.likes,
  });

  final int id;
  final String content;
  final String language;
  final UserEntity userEntity;
  final String createdAt;
  final List<FeedPostCommentEntity>? comments;
  final List<FeedPostLikeEntity>? likes;

  @override
  List<Object?> get props => [
        id,
        content,
        language,
        userEntity,
        createdAt,
        comments,
        likes,
      ];
}
