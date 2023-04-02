import 'package:dartz/dartz.dart';
import 'package:expatx/features/tabs/history/domain/entities/history_entity.dart';

abstract class HistoryRepository {
  Future<Either<String, List<HistoryEntity>>> getJobHistory();
}
