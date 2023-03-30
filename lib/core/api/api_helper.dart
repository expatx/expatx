import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:netigo_front/core/api/api_endpoints.dart';
import 'package:netigo_front/core/api/rest_client.dart';
import 'package:netigo_front/core/error/exceptions.dart';
import 'package:netigo_front/features/shared/data/models/user_model.dart';

import '../../features/shared/domain/entities/user_entity.dart';
import '../cache/cache_helper_impl.dart';

abstract class ApiHelper {
  Future<Response> getFinances();
  Future<UserModel> register(
      {required String firstName,
      required String lastName,
      required String email,
      required Password password});
  Future<UserModel> login({required String email, required Password password});
  Future<List> getFeedItems(int userId);
}

class ApiHelperImpl extends ApiHelper {
  final RestClient restClient;

  ApiHelperImpl({required this.restClient});

  @override
  Future<UserModel> login(
      {required String email, required Password password}) async {
    try {
      String body = json.encode({
        "user": {"email": email, "password": password.value}
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
      required Password password}) async {
    try {
      String body = json.encode({
        "user": {
          "first_name": firstName,
          "last_name": lastName,
          "email": email,
          "password": password.value
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
  Future<List> getFeedItems(int userId) async {
    try {
      final response = await restClient.get(
        PublicOrProtected.protected,
        ApiEndpoints.getFeedItems(userId),
      );
       return response.data;
    } on CustomException catch (e) {
      throw e.errorMessage;
    }
  }
}
