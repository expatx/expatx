import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/create_post.dart';
import 'create_post_event.dart';
import 'create_post_state.dart';

class CreatePostBloc extends Bloc<CreatePostEvent, CreatePostState> {
  late CreatePost createPost;

  CreatePostBloc({required this.createPost}) : super(CreatePostInitial()) {
    on<CreatePostSubmit>(_onCreatePostSubmit);
  }

  Future<void> _onCreatePostSubmit(
    CreatePostSubmit event,
    Emitter<CreatePostState> emit,
  ) async {
    emit(CreatePostLoading());
    try {
      final response = await createPost
          .call(CreatePostParams(createPostModel: event.createPostModel));
      response.fold(
        (l) => emit(CreatePostFailure(errorMessage: l.toString())),
        (r) => emit(CreatePostSuccess()),
      );
    } catch (_) {
      emit(CreatePostFailure(errorMessage: "Failed to create post"));
    }
  }
}
