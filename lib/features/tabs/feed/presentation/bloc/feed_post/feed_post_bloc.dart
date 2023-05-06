import 'package:expatx/features/tabs/feed/presentation/bloc/feed_post/feed_post_event.dart';
import 'package:expatx/features/tabs/feed/presentation/bloc/feed_post/feed_post_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/like_feed_post.dart';

class FeedPostBloc extends Bloc<FeedPostEvent, FeedPostState> {
  FeedPostBloc({
    required this.likePost,
  }) : super(FeedPostInitial()) {
    on<LikeFeedPostEvent>(_onLikePostEvent);
  }

  late LikeFeedPost likePost;

  Future<void> _onLikePostEvent(
    LikeFeedPostEvent event,
    Emitter<FeedPostState> emit,
  ) async {
    try {
      emit(LikeFeedPostLoading(feedPostId: event.feedPostId));
      await Future.delayed(const Duration(seconds: 2));
      final response = await likePost.call(LikeFeedPostParams(
          feedPostId: event.feedPostId, userId: event.userId));
      response.fold(
          (l) => emit(
                LikeFeedPostFailure(
                    errorMessage: l.toString(), feedPostId: event.feedPostId),
              ), (r) async {
        emit(LikeFeedPostSuccess(feedEntity: r));
      });
    } catch (_) {
      emit(
        LikeFeedPostFailure(
          errorMessage: "Failed to like post",
          feedPostId: event.feedPostId,
        ),
      );
    }
  }
}
