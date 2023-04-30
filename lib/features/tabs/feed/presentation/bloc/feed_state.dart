part of 'feed_bloc.dart';

class FeedState extends Equatable {
  @override
  List<Object> get props => [];
}

class FeedInitial extends FeedState {}

class FeedLoading extends FeedState {}

class FeedSuccess extends FeedState {
  final List<FeedPostEntity> feedEntity;

  FeedSuccess({required this.feedEntity});
}

class FeedFailure extends FeedState {
  final String errorMessage;

  FeedFailure({required this.errorMessage});
}

class CreateFeedPostInitial extends FeedState {}

class CreateFeedPostLoading extends FeedState {}

class CreatePostSuccess extends FeedState {}

class CreateFeedPostFailure extends FeedState {
  final String errorMessage;

  CreateFeedPostFailure({required this.errorMessage});
}
