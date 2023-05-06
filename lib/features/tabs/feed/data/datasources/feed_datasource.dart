import 'package:dio/dio.dart';
import 'package:expatx/features/tabs/feed/data/models/feed_post_model.dart';

import '../../../../../core/data_helper.dart';
import '../models/create_feed_post_model.dart';

abstract class FeedDataSource {
  Future<List<FeedPostModel>> getFeedItems();
  Future<Response> createPost(CreateFeedPostModel createPostModel);
  Future<Response> likePost(int postId, int userId);
}

class FeedDataSourceImpl extends FeedDataSource {
  // Create a Rest Client Class to Handle API Calling
  // final RestClient restClient;
  final _dataHelper = DataHelperImpl.instance;

  @override
  Future<List<FeedPostModel>> getFeedItems() async {
    List response = await _dataHelper.apiHelper.getFeedItems();
    List<FeedPostModel> listFeedItems = response
        .map<FeedPostModel>((json) => FeedPostModel.fromJson(json))
        .toList();
    return listFeedItems;
  }

  @override
  Future<Response> createPost(CreateFeedPostModel createPostModel) async {
    return await _dataHelper.apiHelper.postFeedItem(createPostModel);
  }

  @override
  Future<Response> likePost(int postId, int userId) async {
    return await _dataHelper.apiHelper.likePost(postId, userId);
  }
}
