import 'package:netigo_front/features/authentication/data/datasources/auth_datasource.dart';
import 'package:netigo_front/features/authentication/domain/entities/logged_in_user.dart';
import 'package:netigo_front/features/authentication/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthDatasource authDatasource;

  AuthRepositoryImpl(this.authDatasource);

  @override
  Stream<AuthStatus> get status => authDatasource.status;

  @override
  Future<LoggedInUser> get loggedInUser => authDatasource.loggedInUser;

  @override
  Future<void> login({
    required String email,
    required String password,
  }) {
    return authDatasource.login(email: email, password: password);
  }

  @override
  Future<void> register({required LoggedInUser loggedInUser}) {
    return authDatasource.register(loggedInUser: loggedInUser);
  }

  @override
  Future<void> logout() {
    return authDatasource.logout();
  }
}
