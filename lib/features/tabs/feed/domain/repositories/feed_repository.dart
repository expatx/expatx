import 'package:dartz/dartz.dart';
import 'package:expatx/features/tabs/feed/domain/entities/feed_post_entity.dart';

import '../../data/models/create_feed_post_model.dart';

abstract class FeedRepository {
  Future<Either<String, List<FeedPostEntity>>> getFeed();
  Future<Either<String, void>> createPost(CreateFeedPostModel createPostModel);
  Future<Either<String, FeedPostEntity>> likePost(int postId, int userId);
}
