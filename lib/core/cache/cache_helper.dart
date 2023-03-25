import 'package:netigo_front/features/authentication/domain/entities/logged_in_user.dart';

import '../../features/tabs/profile/data/model/profile_model.dart';

abstract class CacheHelper {
  Future<void> cacheProfile(ProfileModel profileToCache);
  Future<ProfileModel> getLastProfile();
  Future<String> getAccessToken();
  Future<void> cacheAccessToken(String accessToken);

  Future<void> cacheCurrentUser(LoggedInUser userToCache);
}
