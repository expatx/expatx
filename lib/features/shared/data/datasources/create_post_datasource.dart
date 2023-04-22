import 'package:dio/dio.dart';
import 'package:expatx/features/shared/data/models/create_post_model.dart';

import '../../../../core/data_helper.dart';

abstract class CreatePostRemoteDataSource {
  Future<Response> createPost(CreatePostModel createPostModel);
}

class CreatePostRemoteDataSourceImpl implements CreatePostRemoteDataSource {
  final _dataHelper = DataHelperImpl.instance;

  @override
  Future<Response> createPost(CreatePostModel createPostModel) async {
   return await _dataHelper.apiHelper.postFeedItem(createPostModel);
  }
}
