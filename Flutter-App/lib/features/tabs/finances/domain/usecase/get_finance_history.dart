import 'package:dartz/dartz.dart';
import 'package:expatx/features/tabs/finances/domain/entity/finance_entity.dart';
import 'package:expatx/features/tabs/finances/domain/repository/finance_repository.dart';

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
