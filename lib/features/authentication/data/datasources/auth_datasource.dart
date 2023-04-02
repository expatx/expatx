import 'dart:async';
import 'package:expatx/core/data_helper.dart';
import 'package:expatx/features/shared/data/models/user_model.dart';

import '../../../../core/cache/cache_helper_impl.dart';
import '../../../shared/domain/entities/user_entity.dart';

enum AuthStatus {
  unknown,
  authenticated,
  unauthenticated,
}

abstract class AuthDatasource {
  Stream<AuthStatus> get status;
  Future<UserEntity> get loggedInUser;
  Future<UserModel> register({
    required String firstName,
    required String lastName,
    required String email,
    required Password password,
  });
  Future<UserModel> login({
    required String email,
    required Password password,
  });
  Future<void> logout();
}

class AuthDatasourceImpl extends AuthDatasource {
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
  Future<UserEntity> get loggedInUser {
    return Future.delayed(const Duration(milliseconds: 300), () async {
      UserModel userModel = await CacheHelperImpl().getCurrentUser();
      return userModel.toEntity();
    });
  }

  @override
  Future<UserModel> login({
    required String email,
    required Password password,
  }) async {
    UserModel userModel =
        await _dataHelper.apiHelper.login(email: email, password: password);

    _updateLoggedInUser(userModel: userModel);

    _controller.add(AuthStatus.authenticated);

    return userModel;
  }

  // throw LoginWithUsernameAndPasswordFailure.fromCode('user-not-found');

  @override
  Future<UserModel> register(
      {required String firstName,
      required String lastName,
      required String email,
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

    return userModel;
  }

  @override
  Future<void> logout() {
    return Future.delayed(const Duration(milliseconds: 300), () async {
      // Clear the current logged in user
      _updateLoggedInUser(userModel: UserModel.empty);
      // Clear all Cache
      await CacheHelperImpl().clearCache();
      _controller.add(AuthStatus.unauthenticated);
    });
  }

  // Cache current user info onto device
  void _updateLoggedInUser({required UserModel userModel}) {
    CacheHelperImpl().cacheCurrentUser(userModel);
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
