import 'dart:convert';

import 'package:api_cache_manager/models/cache_db_model.dart';
import 'package:api_cache_manager/utils/cache_manager.dart';
import 'package:netigo_front/core/cache/cache_helper.dart';
import 'package:netigo_front/features/authentication/domain/entities/logged_in_user.dart';
import 'package:netigo_front/features/feed/profile/data/model/profile_model.dart';

class CacheHelperImpl extends CacheHelper {
  final APICacheManager cacheManager = APICacheManager();

  @override
  Future<void> cacheProfile(ProfileModel profileToCache) async {
    final apiCacheDBModel = APICacheDBModel(
      key: "profile",
      syncData: json.encode(profileToCache.toJson()),
    );
    await cacheManager.addCacheData(apiCacheDBModel);
  }

  @override
  Future<ProfileModel> getLastProfile() async {
    var isCacheExist = await cacheManager.isAPICacheKeyExist("profile");
    if (isCacheExist) {
      var cacheData = await cacheManager.getCacheData("profile");
      return ProfileModel.fromJson(json.decode(cacheData.syncData));
    } else {
      throw Exception();
    }
  }

  @override
  Future<void> cacheAccessToken(String accessToken) {
    // TODO: implement cacheAccessToken
    throw UnimplementedError();
  }

  @override
  Future<String> getAccessToken() async {
    return "";
  }

  @override
  Future<void> cacheCurrentUser(LoggedInUser userToCache) async {
    final apiCacheDBModel = APICacheDBModel(
      key: "profile",
      syncData: json.encode(userToCache.toJson()),
    );
    await cacheManager.addCacheData(apiCacheDBModel);
  }
}
