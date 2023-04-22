import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../domain/repositories/create_post_repository.dart';
import '../datasources/create_post_datasource.dart';
import '../models/create_post_model.dart';

class CreatePostRepositoryImpl implements CreatePostRepository {
  final CreatePostRemoteDataSource remoteDataSource;

  CreatePostRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<String, void>> createPost(
      CreatePostModel createPostModel) async {
    try {
      Response response = await remoteDataSource.createPost(createPostModel);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return const Right(null);
      } else {
        return const Left('Server error');
      }
    } on Exception {
      return const Left('Server error');
    }
  }
}
