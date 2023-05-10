import 'package:dartz/dartz.dart';

import '../../../shared/domain/entities/user_entity.dart';
import '../../data/datasources/auth_datasource.dart';

abstract class AuthRepository {
  Stream<AuthStatus> get status;
  Future<UserEntity> get loggedInUser;
  Future<Either<String, UserEntity>> register(
      {required String firstName,
      required String lastName,
      required String email,
      required String password});
  Future<Either<String, UserEntity>> login(
      {required String email, required String password});
  Future<void> logout();
}
