import 'package:dartz/dartz.dart';
import 'package:netigo_front/features/feed/finances/domain/entity/finance_entity.dart';
import 'package:netigo_front/features/feed/finances/domain/repository/finance_repository.dart';

import '../../../../shared/domain/usecases/usecases.dart';

class GetFinanceHistory
    implements UseCase<Either<String, List<FinanceEntity>>, NoParams> {
  final FinanceRepository repository;

  GetFinanceHistory({required this.repository});

  @override
  call(NoParams params) async {
    return await repository.getFinanceHistory();
  }
}
