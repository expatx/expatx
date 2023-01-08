import '../../data/datasources/auth_datasource.dart';
import '../entities/logged_in_user.dart';

abstract class AuthRepository {
  Stream<AuthStatus> get status;
  Future<LoggedInUser> get loggedInUser;
  Future<void> register({required LoggedInUser loggedInUser});
  Future<void> login({required String email, required String password});
  Future<void> logout();
}
