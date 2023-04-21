import 'package:equatable/equatable.dart';

class FeedPostCommentEntity extends Equatable {
  const FeedPostCommentEntity({
    required this.id,
    required this.comment,
    required this.feedPostId,
    required this.userId,
    required this.createdAt,
  });

  final int id;
  final String comment;
  final int feedPostId;
  final int userId;
  final String createdAt;

  @override
  List<Object?> get props => [
        id,
        comment,
        feedPostId,
        userId,
        createdAt,
      ];
}
