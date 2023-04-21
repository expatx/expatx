import 'package:expatx/features/tabs/feed/data/models/feed_post_model.dart';

import '../../../../../core/data_helper.dart';

abstract class FeedDataSource {
  Future<List<FeedPostModel>> getFeedItems(userId);
}

class FeedDataSourceImpl extends FeedDataSource {
  // Create a Rest Client Class to Handle API Calling
  // final RestClient restClient;
  final _dataHelper = DataHelperImpl.instance;

  @override
  Future<List<FeedPostModel>> getFeedItems(userId) async {
    List response = await _dataHelper.apiHelper.getFeedItems();
    List<FeedPostModel> listFeedItems = response
        .map<FeedPostModel>((json) => FeedPostModel.fromJson(json))
        .toList();
    return listFeedItems;
  }
}
