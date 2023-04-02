import 'package:dartz/dartz.dart';
import 'package:expatx/features/tabs/feed/domain/entities/feed_entity.dart';

abstract class FeedRepository {
  Future<Either<String, List<FeedEntity>>> getFeedHistory();
}
