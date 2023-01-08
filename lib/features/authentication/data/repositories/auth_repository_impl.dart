import 'package:netigo_front/features/authentication/data/datasources/auth_datasource.dart';
import 'package:netigo_front/features/authentication/domain/entities/logged_in_user.dart';

class AuthRepositoryImpl {
  final AuthDatasource authDatasource;

  AuthRepositoryImpl(this.authDatasource);

  Future<void> login({
    required String email,
    required String password,
  }) {
    return authDatasource.login(email: email, password: password);
  }

  Future<void> register({required LoggedInUser loggedInUser}) {
    return authDatasource.register(loggedInUser: loggedInUser);
  }

  Future<void> logout() {
    return authDatasource.logout();
  }
}
