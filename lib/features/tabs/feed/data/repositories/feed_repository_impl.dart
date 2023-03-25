import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:netigo_front/features/tabs/feed/data/datasources/feed_datasource.dart';
import 'package:netigo_front/features/tabs/feed/data/models/feed_model.dart';
import 'package:netigo_front/features/tabs/feed/domain/entities/feed_entity.dart';
import 'package:netigo_front/features/tabs/feed/domain/repositories/feed_repository.dart';

class FeedRepositoryImpl implements FeedRepository {
  final FeedDataSource remoteDataSource;

  FeedRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<String, List<FeedEntity>>> getFeedHistory() async {
    try {
      final Response response = await remoteDataSource.getFeedHistory();

      final data = response.data['data'];

      List<FeedEntity> entities = data
          .map<FeedEntity>((entity) => FeedModel.fromJson(entity).toEntity())
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
