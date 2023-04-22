import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
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
      await remoteDataSource.createPost(createPostModel);
      return const Right(null);
    } on ServerException {
      return const Left('Server error');
    }
  }
}
