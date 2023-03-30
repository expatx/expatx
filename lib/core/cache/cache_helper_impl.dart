import 'dart:convert';

import 'package:api_cache_manager/models/cache_db_model.dart';
import 'package:api_cache_manager/utils/cache_manager.dart';
import 'package:netigo_front/core/cache/cache_helper.dart';
import 'package:netigo_front/features/shared/data/models/user_model.dart';
import 'package:netigo_front/features/tabs/profile/data/model/profile_model.dart';

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
 Future<void> cacheAccessToken(String accessToken) async {
    final apiCacheDBModel = APICacheDBModel(
      key: "access_token",
      syncData: accessToken,
    );

    await cacheManager.addCacheData(apiCacheDBModel);
  }

  @override
  Future<String> getAccessToken() async {
    var isCacheExist = await cacheManager.isAPICacheKeyExist("access_token");
    if (isCacheExist) {
      var cacheData = await cacheManager.getCacheData("access_token");

      return cacheData.syncData;
    } else {
      throw Exception();
    }
  }
  
  @override
  Future<void> cacheCurrentUser(UserModel userToCache) async {
    final apiCacheDBModel = APICacheDBModel(
      key: "current_user",
      syncData: json.encode(userToCache.toJson()),
    );
    await cacheManager.addCacheData(apiCacheDBModel);
  }

  @override
  Future<UserModel> getCurrentUser() async {
    var isCacheExist = await cacheManager.isAPICacheKeyExist("current_user");
    if (isCacheExist) {
      var cacheData = await cacheManager.getCacheData("current_user");
      return UserModel.fromJson(json.decode(cacheData.syncData));
    } else {
      throw Exception();
    }
  }

  Future<void> clearCache() async {
    await cacheManager.emptyCache();
  }
}


