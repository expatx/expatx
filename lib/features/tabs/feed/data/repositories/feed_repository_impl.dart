import 'package:dartz/dartz.dart';
import 'package:expatx/features/tabs/feed/data/datasources/feed_datasource.dart';
import 'package:expatx/features/tabs/feed/data/models/feed_model.dart';
import 'package:expatx/features/tabs/feed/domain/entities/feed_entity.dart';
import 'package:expatx/features/tabs/feed/domain/repositories/feed_repository.dart';

import '../../../../../core/cache/cache_helper_impl.dart';
import '../../../../shared/data/models/user_model.dart';

class FeedRepositoryImpl implements FeedRepository {
  final FeedDataSource remoteDataSource;

  FeedRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<String, List<FeedEntity>>> getFeedHistory() async {
    try {
      UserModel currentUser = await CacheHelperImpl().getCurrentUser();
      int currentUserId = currentUser.id;

      final List<FeedModel> listFeedModels =
          await remoteDataSource.getFeedItems(currentUserId);

      // Convert List of models to list of entities
      List<FeedEntity> entities = [];
      for (FeedModel feedModel in listFeedModels) {
        FeedEntity newEntity = feedModel.toEntity();
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
