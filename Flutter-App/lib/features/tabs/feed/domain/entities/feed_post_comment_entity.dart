import 'package:equatable/equatable.dart';
import 'package:expatx/features/shared/domain/entities/user_entity.dart';

class FeedPostCommentEntity extends Equatable {
  const FeedPostCommentEntity({
    required this.id,
    required this.comment,
    required this.feedPostId,
    required this.user,
    required this.createdAt,
  });

  final int id;
  final String comment;
  final int feedPostId;
  final UserEntity user;
  final String createdAt;

  @override
  List<Object?> get props => [
        id,
        comment,
        feedPostId,
        user,
        createdAt,
      ];
}
