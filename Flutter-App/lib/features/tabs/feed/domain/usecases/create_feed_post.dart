import 'package:dartz/dartz.dart';
import 'package:expatx/features/tabs/feed/data/models/create_feed_post_model.dart';
import 'package:expatx/features/shared/domain/usecases/usecases.dart';
import 'package:expatx/features/tabs/feed/domain/repositories/feed_repository.dart';

class CreateFeedPost
    implements UseCase<Either<String, void>, CreateFeedPostParams> {
  final FeedRepository repository;

  CreateFeedPost({required this.repository});

  @override
  call(CreateFeedPostParams params) async {
    return await repository.createPost(params.createPostModel);
  }
}

class CreateFeedPostParams extends Params {
  final CreateFeedPostModel createPostModel;
  CreateFeedPostParams({required this.createPostModel});
  @override
  List<Object?> get props => [createPostModel];
}
