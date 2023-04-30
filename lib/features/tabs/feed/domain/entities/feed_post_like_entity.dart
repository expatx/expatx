import 'package:equatable/equatable.dart';
import 'package:expatx/features/shared/domain/entities/user_entity.dart';

class FeedPostLikeEntity extends Equatable {
  final int id;
  final UserEntity user;
  final int feedPostId;
  final String createdAt;

  const FeedPostLikeEntity({
    required this.id,
    required this.user,
    required this.feedPostId,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [
        id,
        user,
        feedPostId,
        createdAt,
      ];
}
