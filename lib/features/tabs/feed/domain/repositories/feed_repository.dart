import 'package:dartz/dartz.dart';
import 'package:netigo_front/features/tabs/feed/domain/entities/feed_entity.dart';

abstract class FeedRepository {
  Future<Either<String, List<FeedEntity>>> getFeedHistory();
}
