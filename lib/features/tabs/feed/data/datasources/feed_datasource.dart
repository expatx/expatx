import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:netigo_front/features/tabs/feed/data/models/feed_model.dart';

import '../../../../../core/data_helper.dart';

abstract class FeedDataSource {

  Future<List<FeedModel>> getFeedItems(userId);
}

class FeedDataSourceImpl extends FeedDataSource {
  // Create a Rest Client Class to Handle API Calling
  // final RestClient restClient;
  final _dataHelper = DataHelperImpl.instance;

  @override
 Future<List<FeedModel>> getFeedItems(userId) async {
    List response = await _dataHelper.apiHelper.getFeedItems(userId);
    List<FeedModel> listFeedItems = response
        .map<FeedModel>((json) => FeedModel.fromJson(json))
        .toList();
    return listFeedItems;
  }
}
