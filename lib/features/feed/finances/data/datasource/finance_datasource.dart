
import 'dart:convert';

import 'package:dio/dio.dart';

abstract class FinanceDataSource {
  Future<Response> getFinanceHistory();
}

class FinanceDataSourceImpl extends FinanceDataSource {
  // Create a Rest Client Class to Handle API Calling
  // final RestClient restClient;

  @override
  Future<Response> getFinanceHistory() async {
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
}