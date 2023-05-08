import 'package:expatx/features/tabs/feed/presentation/bloc/feed_post/feed_post_event.dart';
import 'package:expatx/features/tabs/feed/presentation/bloc/feed_post/feed_post_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/like_feed_post.dart';
import '../../../domain/usecases/unlike_feed_post.dart';

class FeedPostBloc extends Bloc<FeedPostEvent, FeedPostState> {
  FeedPostBloc({
    required this.likePost,
    required this.unlikePost,
  }) : super(FeedPostInitial()) {
    on<LikeFeedPostEvent>(_onLikePostEvent);
    on<UnlikeFeedPostEvent>(_onUnlikePostEvent);
  }

  late LikeFeedPost likePost;
  late UnlikeFeedPost unlikePost;

  Future<void> _onLikePostEvent(
    LikeFeedPostEvent event,
    Emitter<FeedPostState> emit,
  ) async {
    try {
      emit(LikeFeedPostLoading(feedPostId: event.feedPostId));

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

  Future<void> _onUnlikePostEvent(
    UnlikeFeedPostEvent event,
    Emitter<FeedPostState> emit,
  ) async {
    try {
      emit(UnlikeFeedPostLoading(feedPostId: event.feedPostId));

      final response = await unlikePost.call(UnlikeFeedPostParams(
          feedPostId: event.feedPostId, userId: event.userId));
      response.fold(
          (l) => emit(
                UnlikeFeedPostFailure(
                    errorMessage: l.toString(), feedPostId: event.feedPostId),
              ), (r) async {
        emit(UnlikeFeedPostSuccess(feedEntity: r));
      });
    } catch (_) {
      emit(
        UnlikeFeedPostFailure(
          errorMessage: "Failed to unlike post",
          feedPostId: event.feedPostId,
        ),
      );
    }
  }
}
