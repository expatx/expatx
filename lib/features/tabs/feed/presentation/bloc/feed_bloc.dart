import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:expatx/features/tabs/feed/domain/entities/feed_post_entity.dart';
import 'package:expatx/features/tabs/feed/domain/usecases/get_feed.dart';

import '../../../../shared/domain/usecases/usecases.dart';
import '../../data/models/create_feed_post_model.dart';
import '../../domain/usecases/create_feed_post.dart';

part 'feed_event.dart';
part 'feed_state.dart';

class FeedBloc extends Bloc<FeedEvent, FeedState> {
  FeedBloc({required this.getFeed}) : super(FeedInitial()) {
    on<GetFeedEvent>(_onGetFeedEvent);
    on<CreateFeedPostSubmit>(_onCreatePostSubmit);
  }

  late GetFeed getFeed;
  late CreateFeedPost createPost;

  Future<void> _onGetFeedEvent(
    GetFeedEvent event,
    Emitter<FeedState> emit,
  ) async {
    emit(FeedLoading());

    // Mock await
    await Future.delayed(const Duration(seconds: 2));

    try {
      final response = await getFeed.call(NoParams());
      response.fold(
        (l) => emit(
          FeedFailure(
            errorMessage: l.toString(),
          ),
        ),
        (r) => emit(FeedSuccess(feedEntity: r)),
      );
    } catch (_) {
      emit(
        FeedFailure(
          errorMessage: "Failed to load feed",
        ),
      );
    }
  }

  Future<void> _onCreatePostSubmit(
    CreateFeedPostSubmit event,
    Emitter<FeedState> emit,
  ) async {
    emit(CreateFeedPostLoading());
    try {
      final response = await createPost
          .call(CreateFeedPostParams(createPostModel: event.createPostModel));
      response.fold(
        (l) => emit(CreateFeedPostFailure(errorMessage: l.toString())),
        (r) async {
          Navigator.of(event.context).pop();
          BlocProvider.of<FeedBloc>(event.context).add(GetFeedEvent());
          emit(CreatePostSuccess());
        },
      );
    } catch (_) {
      emit(CreateFeedPostFailure(errorMessage: "Failed to create post"));
    }
  }
}
