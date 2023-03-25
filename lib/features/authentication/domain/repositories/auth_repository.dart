import 'package:dartz/dartz.dart';

import '../../../shared/domain/entities/user_entity.dart';
import '../../data/datasources/auth_datasource.dart';
import '../entities/logged_in_user.dart';

abstract class AuthRepository {
  Stream<AuthStatus> get status;
  Future<LoggedInUser> get loggedInUser;
  Future<Either<String, UserEntity>> register(
      {required String firstName,
      required String lastName,
      required Email email,
      required Password password});
  Future<Either<String, UserEntity>> login(
      {required Email email, required Password password});
  Future<void> logout();
}
