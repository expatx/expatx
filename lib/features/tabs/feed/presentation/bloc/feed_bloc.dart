import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:expatx/features/tabs/feed/domain/entities/feed_post_entity.dart';
import 'package:expatx/features/tabs/feed/domain/usecases/get_feed.dart';

import '../../../../shared/domain/usecases/usecases.dart';

part 'feed_event.dart';
part 'feed_state.dart';

class FeedBloc extends Bloc<FeedEvent, FeedState> {
  FeedBloc({required this.getFeed}) : super(FeedInitial()) {
    on<GetFeedEvent>(_onGetFeedEvent);
  }

  late GetFeed getFeed;

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
}
