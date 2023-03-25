import 'package:dartz/dartz.dart';
import 'package:netigo_front/features/tabs/finances/domain/entity/finance_entity.dart';

abstract class FinanceRepository {
  Future<Either<String, List<FinanceEntity>>> getFinanceHistory();
}
