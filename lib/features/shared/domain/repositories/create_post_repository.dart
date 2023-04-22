import 'package:dartz/dartz.dart';
import 'package:expatx/features/shared/data/models/create_post_model.dart';

abstract class CreatePostRepository {
  Future<Either<String, void>> createPost(CreatePostModel createPostModel);
}