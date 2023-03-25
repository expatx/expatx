import 'package:dartz/dartz.dart';
import 'package:netigo_front/features/feed/history/domain/entities/history_entity.dart';

abstract class HistoryRepository {
  Future<Either<String, List<HistoryEntity>>> getJobHistory();
}
