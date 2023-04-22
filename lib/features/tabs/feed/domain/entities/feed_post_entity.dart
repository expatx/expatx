import 'package:equatable/equatable.dart';
import 'package:expatx/features/tabs/feed/domain/entities/feed_post_comment_entity.dart';

class FeedPostEntity extends Equatable {
  const FeedPostEntity({
    required this.id,
    required this.content,
    required this.language,
    required this.userId,
    required this.createdAt,
    required this.comments,
  });

  final int id;
  final String content;
  final String language;
  final int userId;
  final String createdAt;
  final List<FeedPostCommentEntity>? comments;

  @override
  List<Object?> get props => [
        id,
        content,
        userId,
        createdAt,
        comments,
      ];
}
