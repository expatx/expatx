import 'package:equatable/equatable.dart';
import 'package:expatx/features/shared/data/models/create_post_model.dart';
import 'package:flutter/material.dart';

class CreatePostEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class CreatePostSubmit extends CreatePostEvent {
  final CreatePostModel createPostModel;
  // Have to pass context in order to properly pop the screen on success
  final BuildContext context;

  CreatePostSubmit({required this.createPostModel, required this.context});

  @override
  List<Object> get props => [createPostModel];
}
