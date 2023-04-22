import 'package:expatx/features/shared/data/models/create_post_model.dart';

import '../../../../core/data_helper.dart';

abstract class CreatePostRemoteDataSource {
  Future<void> createPost(CreatePostModel createPostModel);
}

class CreatePostRemoteDataSourceImpl implements CreatePostRemoteDataSource {
  final _dataHelper = DataHelperImpl.instance;

  @override
  Future<void> createPost(CreatePostModel createPostModel) async {
    await _dataHelper.apiHelper.postFeedItem(createPostModel);
  }
}
