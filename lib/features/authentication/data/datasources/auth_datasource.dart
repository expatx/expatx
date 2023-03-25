import 'dart:async';
import 'package:netigo_front/core/data_helper.dart';
import 'package:netigo_front/features/authentication/domain/entities/logged_in_user.dart';
import 'package:netigo_front/features/shared/data/models/user_model.dart';

import '../../../shared/domain/entities/user_entity.dart';

enum AuthStatus {
  unknown,
  authenticated,
  unauthenticated,
}

abstract class AuthDatasource {
  Stream<AuthStatus> get status;
  Future<LoggedInUser> get loggedInUser;
  Future<UserModel> register({
    required String firstName,
    required String lastName,
    required Email email,
    required Password password,
  });
  Future<UserModel> login({
    required Email email,
    required Password password,
  });
  Future<void> logout();
}

class AuthDatasourceImpl extends AuthDatasource {
  // If Cache Client is null then we will create a new instance of CacheClient
  AuthDatasourceImpl({CacheClient? cache}) : _cache = cache ?? CacheClient();

  final CacheClient _cache;
  static const userCacheKey = '__user_cache_key';
  final _controller = StreamController<AuthStatus>.broadcast();
  final _dataHelper = DataHelperImpl.instance;

  // A  stream that can tell as at any point in time if their are changes in authentication status of the user.
  @override
  Stream<AuthStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    // //Initial status of our app
    yield AuthStatus.unauthenticated;
    //We can listen to this stream from other parts of the app
    yield* _controller.stream;
  }

  @override
  Future<LoggedInUser> get loggedInUser {
    return Future.delayed(const Duration(milliseconds: 300), () {
      // Here we are always just saving one value (User Object) so we can always use the same key
      return _cache.read(key: userCacheKey) ?? LoggedInUser.empty;
    });
  }

  @override
  Future<UserModel> login({
    required Email email,
    required Password password,
  }) async {
    UserModel userModel =
        await _dataHelper.apiHelper.login(email: email, password: password);
    // _updateLoggedInUser(
    //   id: userModel.id,
    //   firstName: userModel.firstName,
    //   lastName: userModel.lastName,
    //   email: userModel.email,
    // );

    _controller.add(AuthStatus.authenticated);

    return userModel;
  }

  // throw LoginWithUsernameAndPasswordFailure.fromCode('user-not-found');

  @override
  Future<UserModel> register(
      {required String firstName,
      required String lastName,
      required Email email,
      required Password password}) async {
    // _updateLoggedInUser(
    //   id: loggedInUser.id,
    //   firstName: loggedInUser.firstName,
    //   lastName: loggedInUser.lastName,
    //   email: loggedInUser.email,
    // );

    UserModel userModel = await _dataHelper.apiHelper.register(
        firstName: firstName,
        lastName: lastName,
        email: email,
        password: password);

    //Still is unathenticated because a user is not automatically logged in after creating an account
    // Current functionality is to redirect to login screen and input credentials again
    _controller.add(AuthStatus.unauthenticated);
    print(userModel);
    return userModel;
  }

  @override
  Future<void> logout() {
    return Future.delayed(const Duration(milliseconds: 300), () {
      _cache.write(key: userCacheKey, value: LoggedInUser.empty);
      _controller.add(AuthStatus.unauthenticated);
    });
  }

  void _updateLoggedInUser({
    int? id,
    String? firstName,
    String? lastName,
    Email? email,
  }) {
    //Take existing value of loggedInUser and save within the cache client
    LoggedInUser loggedInUser =
        _cache.read(key: userCacheKey) ?? LoggedInUser.empty;

    // Use copyWith method to update any fields that have been changed
    _cache.write(
      key: userCacheKey,
      value: loggedInUser.copyWith(
        id: id,
        firstName: firstName,
        lastName: lastName,
        email: email,
      ),
    );
  }
}

// Everytime we login we need to save info about our currently logged in user. This is our local datasource.

class CacheClient {
  CacheClient() : _cache = <String, Object>{};

  //Store the info of our currently logged in user in this map
  final Map<String, Object> _cache;

  // Add info of our currently logged in user every time they login
  void write<T extends Object>({required String key, required T value}) {
    _cache[key] = value;
  }

  // Take the info of our currently logged in user and use anytime we need it in our app.
  T? read<T extends Object>({required String key}) {
    final value = _cache[key];
    if (value is T) return value;
    return null;
  }
}

class LoginWithUsernameAndPasswordFailure implements Exception {
  const LoginWithUsernameAndPasswordFailure(this.message);

  final String message;

  factory LoginWithUsernameAndPasswordFailure.fromCode(String code) {
    switch (code) {
      case 'invalid-username':
        return const LoginWithUsernameAndPasswordFailure(
            'Username is not valid');

      case 'user-not-found':
        return const LoginWithUsernameAndPasswordFailure(
            'Username is not found, please create an account');
      default:
        return const LoginWithUsernameAndPasswordFailure(
            'An unknown exception occured.');
    }
  }
}
