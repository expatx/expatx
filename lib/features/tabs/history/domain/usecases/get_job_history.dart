import 'package:dartz/dartz.dart';
import 'package:expatx/features/tabs/history/domain/entities/history_entity.dart';
import 'package:expatx/features/tabs/history/domain/repositories/history_repository.dart';

import '../../../../shared/domain/usecases/usecases.dart';

class GetJobHistory
    implements UseCase<Either<String, List<HistoryEntity>>, NoParams> {
  final HistoryRepository repository;

  GetJobHistory({required this.repository});

  @override
  call(NoParams params) async {
    return await repository.getJobHistory();
  }
}
