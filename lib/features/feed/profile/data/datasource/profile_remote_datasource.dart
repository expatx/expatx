import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:netigo_front/features/feed/profile/data/model/profile_model.dart';

abstract class ProfileRemoteDataSource {
  Future<ProfileModel> getUserProfile();
}

class ProfileRemoteDatasourceImpl extends ProfileRemoteDataSource {
  // Create a Rest Client Class to Handle API Calling
  // final RestClient restClient;

  @override
  Future<ProfileModel> getUserProfile() async {
    // Call the actual api
    // final response = await restClient.get(APIType.PROTECTED, API.currentPoints);

    // Calling mock api
    // Define your mock JSON object
    var mockJson = '''
    {
    "data": 
        {
            "id": "asfafa-asfasfa-fasfasf",
            "userName": "Jake Woodruff",
            "userEmail": "jkwoodruff93@gmail.com",
            "image": "https://upload.wikimedia.org/wikipedia/commons/thumb/4/4f/Rosy-faced_lovebird_%28Agapornis_roseicollis_roseicollis%29.jpg/1000px-Rosy-faced_lovebird_%28Agapornis_roseicollis_roseicollis%29.jpg"
        }
  }
    ''';

    Response response = await Future.value(
      Response(
        data: jsonDecode(mockJson),
        requestOptions: RequestOptions(),
      ),
    );
    ProfileModel profileModel = ProfileModel.fromJson(response.data['data']);

    // Return the Dart object
    return profileModel;
  }
}
