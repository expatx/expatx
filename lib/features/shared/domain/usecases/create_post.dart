import 'package:dartz/dartz.dart';
import 'package:expatx/features/shared/data/models/create_post_model.dart';
import 'package:expatx/features/shared/domain/usecases/usecases.dart';
import '../repositories/create_post_repository.dart';

class CreatePost implements UseCase<Either<String, void>, CreatePostParams> {
  final CreatePostRepository repository;

  CreatePost({required this.repository});

  @override
  call(CreatePostParams params) async {
    return await repository.createPost(params.createPostModel);
  }
}

class CreatePostParams extends Params {
  final CreatePostModel createPostModel;
  CreatePostParams({required this.createPostModel});
  @override
  List<Object?> get props => [createPostModel];
}
