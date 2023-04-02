import 'package:expatx/core/cache/cache_helper_impl.dart';
import 'package:expatx/features/tabs/profile/data/model/profile_model.dart';

abstract class ProfileLocalDatasource {
  // Gets the cached ProfileModel which was gotten the last time the user had an internet connection.
  Future<ProfileModel> getLastProfile();
  Future<void> cacheProfile(ProfileModel profileToCache);
}

class ProfileLocalDatasourceImpl implements ProfileLocalDatasource {
  @override
  Future<ProfileModel> getLastProfile() async {
    return CacheHelperImpl().getLastProfile();
  }

  @override
  Future<void> cacheProfile(ProfileModel profileToCache) async {
    return CacheHelperImpl().cacheProfile(profileToCache);
  }
}
