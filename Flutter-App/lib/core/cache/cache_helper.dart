import '../../features/shared/data/models/user_model.dart';
import '../../features/tabs/profile/data/model/profile_model.dart';

abstract class CacheHelper {
  Future<void> cacheProfile(ProfileModel profileToCache);
  Future<ProfileModel> getLastProfile();
  Future<String> getAccessToken();
  Future<void> cacheAccessToken(String accessToken);

   Future<UserModel> getCurrentUser();
  Future<void> cacheCurrentUser(UserModel userToCache);
}

