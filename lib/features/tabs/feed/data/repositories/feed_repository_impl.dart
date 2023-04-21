import 'package:dartz/dartz.dart';
import 'package:expatx/features/tabs/feed/data/datasources/feed_datasource.dart';
import 'package:expatx/features/tabs/feed/data/models/feed_post_model.dart';
import 'package:expatx/features/tabs/feed/domain/entities/feed_post_entity.dart';
import 'package:expatx/features/tabs/feed/domain/repositories/feed_repository.dart';

import '../../../../../core/cache/cache_helper_impl.dart';
import '../../../../shared/data/models/user_model.dart';

class FeedRepositoryImpl implements FeedRepository {
  final FeedDataSource remoteDataSource;

  FeedRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<String, List<FeedPostEntity>>> getFeedHistory() async {
    try {
      UserModel currentUser = await CacheHelperImpl().getCurrentUser();
      int currentUserId = currentUser.id;

      final List<FeedPostModel> listFeedModels =
          await remoteDataSource.getFeedItems(currentUserId);

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
}
