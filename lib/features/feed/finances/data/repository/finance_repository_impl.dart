import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:netigo_front/features/feed/finances/data/datasource/finance_datasource.dart';
import 'package:netigo_front/features/feed/finances/data/model/finance_model.dart';
import 'package:netigo_front/features/feed/finances/domain/entity/finance_entity.dart';
import 'package:netigo_front/features/feed/finances/domain/repository/finance_repository.dart';

class FinanceRepositoryImpl implements FinanceRepository {
  final FinanceDataSource remoteDataSource;

  FinanceRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<String, List<FinanceEntity>>> getFinanceHistory() async {
    try {
      final Response response = await remoteDataSource.getFinanceHistory();

      final data = response.data['data'];

      List<FinanceEntity> entities = data
          .map<FinanceEntity>(
              (entity) => FinanceModel.fromJson(entity).toEntity())
          .toList();

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
