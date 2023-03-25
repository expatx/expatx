import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:netigo_front/features/feed/history/data/datasources/history_datasource.dart';
import 'package:netigo_front/features/feed/history/data/models/history_model.dart';
import 'package:netigo_front/features/feed/history/domain/entities/history_entity.dart';
import 'package:netigo_front/features/feed/history/domain/repositories/history_repository.dart';

class HistoryRepositoryImpl implements HistoryRepository {
  final HistoryDataSource remoteDataSource;

  HistoryRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<String, List<HistoryEntity>>> getJobHistory() async {
    try {
      final Response response = await remoteDataSource.getJobHistory();

      final data = response.data['data'];

      List<HistoryEntity> entities = data
          .map<HistoryEntity>(
              (entity) => HistoryModel.fromJson(entity).toEntity())
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
