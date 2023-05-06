import 'package:equatable/equatable.dart';

class FeedPostEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LikeFeedPostEvent extends FeedPostEvent {
  final int feedPostId;
  final int userId;

  LikeFeedPostEvent({required this.feedPostId, required this.userId});

  @override
  List<Object> get props => [feedPostId, userId];
}
