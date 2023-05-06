import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:expatx/features/tabs/feed/data/datasources/feed_datasource.dart';
import 'package:expatx/features/tabs/feed/data/models/feed_post_model.dart';
import 'package:expatx/features/tabs/feed/domain/entities/feed_post_entity.dart';
import 'package:expatx/features/tabs/feed/domain/repositories/feed_repository.dart';

import '../models/create_feed_post_model.dart';

class FeedRepositoryImpl implements FeedRepository {
  final FeedDataSource remoteDataSource;

  FeedRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<String, List<FeedPostEntity>>> getFeed() async {
    try {
      // UserModel currentUser = await CacheHelperImpl().getCurrentUser();
      // int currentUserId = currentUser.id;

      final List<FeedPostModel> listFeedModels =
          await remoteDataSource.getFeedItems();

      // Convert List of models to list of entities
      List<FeedPostEntity> entities = [];
      for (FeedPostModel feedModel in listFeedModels) {
        FeedPostEntity newEntity = feedModel.toEntity();
        entities.add(newEntity);
      }

      return Right(entities);
    } catch (e) {
      // Ideally use Log
      // Log.error(e.toString());

      // ignore: avoid_print
      print("Error: ${e.toString()}");

      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, void>> createPost(
      CreateFeedPostModel createPostModel) async {
    try {
      Response response = await remoteDataSource.createPost(createPostModel);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return const Right(null);
      } else {
        return const Left('Server error');
      }
    } on Exception {
      return const Left('Server error');
    }
  }
  
  @override
  Future<Either<String, void>> likePost(int postId, int userId) async {
     try {
      Response response = await remoteDataSource.likePost(postId, userId);

      if (response.statusCode == 200) {
        return const Right(null);
      } else {
        return const Left('Server error');
      }
    } on Exception {
      return const Left('Server error');
    }
  }
}
