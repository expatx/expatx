import 'package:netigo_front/core/api/api_endpoints.dart';
import 'package:netigo_front/core/api/api_helper.dart';
import 'package:netigo_front/core/cache/cache_helper_impl.dart';

import 'api/rest_client.dart';
import 'cache/cache_helper.dart';

abstract class DataHelper {
  setApiHelper(ApiHelper apiHelper);

  setCacheHelper(CacheHelper cacheHelper);

  ApiHelper get apiHelper;

  CacheHelper get cacheHelper;
}

class DataHelperImpl implements DataHelper {
  DataHelperImpl._internal() {
    _apiHelper = ApiHelperImpl(
      restClient: RestClient(ApiEndpoints.apiBaseUrl),
    );

    _cacheHelper = CacheHelperImpl();
  }

  static final DataHelperImpl _singleton = DataHelperImpl._internal();
  late ApiHelper _apiHelper;
  late CacheHelper _cacheHelper;

  static DataHelperImpl get instance => _singleton;

  @override
  setApiHelper(ApiHelper apiHelper) {
    _apiHelper = apiHelper;
  }

  @override
  ApiHelper get apiHelper => _apiHelper;

  @override
  CacheHelper get cacheHelper => _cacheHelper;

  @override
  setCacheHelper(CacheHelper cacheHelper) {
    _cacheHelper = cacheHelper;
  }
}
