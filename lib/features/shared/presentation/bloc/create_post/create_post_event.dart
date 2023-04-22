import 'package:equatable/equatable.dart';
import 'package:expatx/features/shared/data/models/create_post_model.dart';

class CreatePostEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class CreatePostSubmit extends CreatePostEvent {
  final CreatePostModel createPostModel;

  CreatePostSubmit({required this.createPostModel});

  @override
  List<Object> get props => [createPostModel];
}