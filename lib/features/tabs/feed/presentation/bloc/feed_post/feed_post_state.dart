import 'package:equatable/equatable.dart';

import '../../../domain/entities/feed_post_entity.dart';

class FeedPostState extends Equatable {
  @override
  List<Object> get props => [];
}

class FeedPostInitial extends FeedPostState {}

class FeedPostLoading extends FeedPostState {}

class FeedPostSuccess extends FeedPostState {
  final FeedPostEntity feedEntity;

  FeedPostSuccess({required this.feedEntity});
}

class LikeFeedPostInitial extends FeedPostState {}

class LikeFeedPostLoading extends FeedPostState {
  final int feedPostId;

  LikeFeedPostLoading({required this.feedPostId});
}

class LikeFeedPostSuccess extends FeedPostState {
  final FeedPostEntity feedEntity;

  LikeFeedPostSuccess({required this.feedEntity});
}

class LikeFeedPostFailure extends FeedPostState {
  final int feedPostId;
  final String errorMessage;

  LikeFeedPostFailure({required this.errorMessage, required this.feedPostId});
}
