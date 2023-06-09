import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:expatx/core/api/api_endpoints.dart';
import 'package:expatx/core/api/rest_client.dart';
import 'package:expatx/core/error/exceptions.dart';
import 'package:expatx/features/tabs/feed/data/models/create_feed_post_model.dart';
import 'package:expatx/features/shared/data/models/user_model.dart';
import '../cache/cache_helper_impl.dart';

abstract class ApiHelper {
  Future<Response> getFinances();
  Future<UserModel> register(
      {required String firstName,
      required String lastName,
      required String email,
      required String password});
  Future<UserModel> login({required String email, required String password});
  Future<void> logout();
  Future<List> getFeedItems();
  Future<Response> postFeedItem(CreateFeedPostModel createPostModel);
  Future<Response> likePost(int postId, int userId);
  Future<Response> unlikePost(int postId, int userId);
}

class ApiHelperImpl extends ApiHelper {
  final RestClient restClient;

  ApiHelperImpl({required this.restClient});

  @override
  Future<UserModel> login(
      {required String email, required String password}) async {
    try {
      String body = json.encode({
        "user": {"email": email, "password": password}
      });
      final response = await restClient.post(
        PublicOrProtected.public,
        ApiEndpoints.login,
        body,
      );

      String bearerToken = response.headers.value("authorization")!;

      await CacheHelperImpl().cacheAccessToken(bearerToken);

      UserModel userModel = UserModel.fromJson(response.data);
      return userModel;
    } on FetchDataException catch (e) {
      throw e.errorMessage;
    }
  }

  @override
  Future<UserModel> register(
      {required String firstName,
      required String lastName,
      required String email,
      required String password}) async {
    try {
      String body = json.encode({
        "user": {
          "first_name": firstName,
          "last_name": lastName,
          "email": email,
          "password": password
        }
      });
      final response = await restClient.post(
        PublicOrProtected.public,
        ApiEndpoints.register,
        body,
      );
      UserModel userModel = UserModel.fromJson(response.data);
      return userModel;
    } on CustomException catch (e) {
      throw e.errorMessage;
    }
  }

  @override
  Future<void> logout() async {
    try {
      await restClient.delete(PublicOrProtected.protected, ApiEndpoints.logout);
    } on CustomException catch (e) {
      throw e.errorMessage;
    }
  }

  @override
  Future<Response> getFinances() async {
    // Call the actual api
    // final response = await restClient.get(APIType.PROTECTED, API.currentPoints);

    // Calling mock api
    // Define your mock JSON object
    var mockJson = '''
    {
    "data": [
        {
            "id": "asfafa-asfasfa-fasfasf",
            "workType": "delivery",
            "expireTime": "2024-07-20",
            "title": "Groceries Delivery",
            "status": "Completed",
            "totalRate": 260.88
        },
        {
            "id": "afasfaa22-asfasfa-fasfasf",
            "workType": "coding",
            "expireTime": "2024-07-20",
            "title": "Build Website",
            "status": "Completed",
            "totalRate": 8000.0
        }
    ]
  }
    ''';

    // Return the Dart object
    return Future.value(
      Response(
        data: jsonDecode(mockJson),
        requestOptions: RequestOptions(),
      ),
    );
  }

  @override
  Future<List> getFeedItems() async {
    try {
      final response = await restClient.get(
        PublicOrProtected.protected,
        ApiEndpoints.feedPosts,
      );
      return response.data;
    } catch (e) {
      return [];
    }
  }

  @override
  Future<Response> postFeedItem(CreateFeedPostModel createPostModel) async {
    try {
      final response = await restClient.post(
        PublicOrProtected.protected,
        ApiEndpoints.feedPosts,
        json.encode(createPostModel),
      );
      return response;
    } on CustomException catch (e) {
      throw e.errorMessage;
    }
  }

  @override
  Future<Response> likePost(int postId, int userId) async {
    try {
      final response = await restClient.post(
        PublicOrProtected.protected,
        ApiEndpoints.feedPostLikes,
        json.encode(
          {
            "feed_post_like": {"feed_post_id": postId, "user_id": userId}
          },
        ),
      );
      return response;
    } on CustomException catch (e) {
      throw e.errorMessage;
    }
  }

  @override
  Future<Response> unlikePost(int postId, int userId) async {
    try {
      final response = await restClient.delete(
        PublicOrProtected.protected,
        ApiEndpoints.feedPostUnlike,
        data: {
          "feed_post_id": postId,
          "user_id": userId,
        },
      );
      return response;
    } on CustomException catch (e) {
      throw e.errorMessage;
    }
  }
}
