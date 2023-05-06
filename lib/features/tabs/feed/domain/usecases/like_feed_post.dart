import 'package:dartz/dartz.dart';
import 'package:expatx/features/shared/domain/usecases/usecases.dart';
import 'package:expatx/features/tabs/feed/domain/entities/feed_post_entity.dart';
import 'package:expatx/features/tabs/feed/domain/repositories/feed_repository.dart';

class LikeFeedPost
    implements UseCase<Either<String, FeedPostEntity>, LikeFeedPostParams> {
  final FeedRepository repository;

  LikeFeedPost({required this.repository});

  @override
  call(LikeFeedPostParams params) async {
    return await repository.likePost(params.feedPostId, params.userId);
  }
}

class LikeFeedPostParams extends Params {
  final int feedPostId;
  final int userId;
  LikeFeedPostParams({required this.feedPostId, required this.userId});
  @override
  List<Object?> get props => [feedPostId, userId];
}
