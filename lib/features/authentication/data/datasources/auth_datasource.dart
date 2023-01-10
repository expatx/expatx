import 'dart:async';

import '../../../shared/domain/entities/user.dart';
import '../../domain/entities/logged_in_user.dart';

enum AuthStatus {
  unknown,
  authenticated,
  unauthenticated,
}

abstract class AuthDatasource {
  Stream<AuthStatus> get status;
  Future<LoggedInUser> get loggedInUser;
  Future<void> register({required LoggedInUser loggedInUser});
  Future<void> login({
    required String email,
    required String password,
  });
  Future<void> logout();
}

class AuthDatasourceImpl extends AuthDatasource {
  AuthDatasourceImpl({CacheClient? cache}) : _cache = cache ?? CacheClient();

  final CacheClient _cache;
  static const userCacheKey = '__user_cache_key';
  final _controller = StreamController<AuthStatus>();

  @override
  Future<LoggedInUser> get loggedInUser {
    return Future.delayed(const Duration(milliseconds: 300), () {
      return LoggedInUser.empty;
    });
  }

  @override
  Future<void> login({
    required String email,
    required String password,
  }) {
    return Future.delayed(
      const Duration(milliseconds: 300),
      () {
        for (final user in _allUsers) {
          if (user.email == email) {
            _updateLoggedInUser(
              id: user.id,
              firstName: user.firstName,
              lastName: user.lastName,
              email: user.email,
            );
            _controller.add(AuthStatus.authenticated);
            return;
          }
        }
        throw const LoginWithUsernameAndPasswordFailure('user-not-found');
      },
    );
  }

  @override
  Future<void> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }

  @override
  Future<void> register({required LoggedInUser loggedInUser}) {
    return Future.delayed(const Duration(milliseconds: 300), () {
      _allUsers.add(loggedInUser);

      _updateLoggedInUser(
        id: loggedInUser.id,
        firstName: loggedInUser.firstName,
        lastName: loggedInUser.lastName,
        email: loggedInUser.email,
      );

      _controller.add(AuthStatus.unauthenticated);
    });
  }

  @override
  Stream<AuthStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    yield AuthStatus.unauthenticated;
  }

  void _updateLoggedInUser({
    String? id,
    String? firstName,
    String? lastName,
    String? email,
  }) {
    LoggedInUser loggedInUser =
        _cache.read(key: userCacheKey) ?? LoggedInUser.empty;

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

  final List<User> _allUsers = <User>[
    const User(
      id: 'user_1',
      firstName: "Jake",
      lastName: 'Woodruff',
      email: "jkwoodruff93@gmail.com",
      imagePath: 'assets/images/image_1.jpg',
    ),
    const User(
      id: 'user_1',
      firstName: "Jake",
      lastName: 'Woodruff',
      email: "jkwoodruff93@gmail.com",
      imagePath: 'assets/images/image_1.jpg',
    ),
    const User(
      id: 'user_1',
      firstName: "Jake",
      lastName: 'Woodruff',
      email: "jkwoodruff93@gmail.com",
      imagePath: 'assets/images/image_1.jpg',
    ),
  ];
}

class CacheClient {
  CacheClient() : _cache = <String, Object>{};

  final Map<String, Object> _cache;

  void write<T extends Object>({required String key, required T value}) {
    _cache[key] = value;
  }

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
