import 'package:dartz/dartz.dart';
import 'package:expatx/features/tabs/finances/domain/entity/finance_entity.dart';

abstract class FinanceRepository {
  Future<Either<String, List<FinanceEntity>>> getFinanceHistory();
}
