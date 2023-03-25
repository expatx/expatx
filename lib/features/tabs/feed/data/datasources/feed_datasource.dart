import 'dart:convert';

import 'package:dio/dio.dart';

abstract class FeedDataSource {
  Future<Response> getFeedHistory();
}

class FeedDataSourceImpl extends FeedDataSource {
  // Create a Rest Client Class to Handle API Calling
  // final RestClient restClient;

  @override
  Future<Response> getFeedHistory() async {
    // Call the actual api
    // final response = await restClient.get(APIType.PROTECTED, API.currentPoints);

    // Calling mock api
    // Define your mock JSON object
    var mockJson = '''
    {
    "data": [
        {
            "id": "asfafa-asfasfa-fasfasf",
            "workType": "Development",
            "expireTime": "2024-07-20",
            "title": "Build Dating App",
            "status": "In Progress"
        },
        {
            "id": "afasfaa22-asfasfa-fasfasf",
            "workType": "Labour",
            "expireTime": "2024-07-20",
            "title": "Dig a hole",
            "status": "Completed"
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
}
