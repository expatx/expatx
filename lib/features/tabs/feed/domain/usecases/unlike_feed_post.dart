import 'package:dartz/dartz.dart';
import 'package:expatx/features/shared/domain/usecases/usecases.dart';
import 'package:expatx/features/tabs/feed/domain/entities/feed_post_entity.dart';
import 'package:expatx/features/tabs/feed/domain/repositories/feed_repository.dart';

class UnlikeFeedPost
    implements UseCase<Either<String, FeedPostEntity>, UnlikeFeedPostParams> {
  final FeedRepository repository;

  UnlikeFeedPost({required this.repository});

  @override
  call(UnlikeFeedPostParams params) async {
    return await repository.unlikePost(params.feedPostId, params.userId);
  }
}

class UnlikeFeedPostParams extends Params {
  final int feedPostId;
  final int userId;
  UnlikeFeedPostParams({required this.feedPostId, required this.userId});
  @override
  List<Object?> get props => [feedPostId, userId];
}
