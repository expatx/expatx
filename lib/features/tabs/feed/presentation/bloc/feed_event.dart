part of 'feed_bloc.dart';

class FeedEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetFeedEvent extends FeedEvent {}

class CreateFeedPostSubmit extends FeedEvent {
  final CreateFeedPostModel createPostModel;
  // Have to pass context in order to properly pop the screen on success
  final BuildContext context;

  CreateFeedPostSubmit({required this.createPostModel, required this.context});

  @override
  List<Object> get props => [createPostModel];
}

class LikeFeedPostEvent extends FeedEvent {
  final int feedPostId;
  final int userId;

  LikeFeedPostEvent({required this.feedPostId, required this.userId});

  @override
  List<Object> get props => [feedPostId, userId];
}
