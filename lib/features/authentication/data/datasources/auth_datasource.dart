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
  @override
  // TODO: implement loggedInUser
  Future<LoggedInUser> get loggedInUser => throw UnimplementedError();

  @override
  Future<void> login({required String email, required String password}) {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  Future<void> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }

  @override
  Future<void> register({required LoggedInUser loggedInUser}) {
    // TODO: implement signup
    throw UnimplementedError();
  }

  @override
  // TODO: implement status
  Stream<AuthStatus> get status => throw UnimplementedError();
}
