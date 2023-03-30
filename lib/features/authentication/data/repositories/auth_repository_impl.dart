import 'package:dartz/dartz.dart';

import '../../../shared/data/models/user_model.dart';
import '../../../shared/domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_datasource.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthDatasource authDatasource;

  AuthRepositoryImpl(this.authDatasource);

  @override
  Stream<AuthStatus> get status => authDatasource.status;

  @override
  Future<UserEntity> get loggedInUser => authDatasource.loggedInUser;

  @override
  Future<Either<String, UserEntity>> login({
    required String email,
    required Password password,
  }) async {
    try {
      UserModel userModel =
          await authDatasource.login(email: email, password: password);
      UserEntity userEntity = userModel.toEntity();
      return Right(userEntity);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, UserEntity>> register(
      {required String firstName,
      required String lastName,
      required String email,
      required Password password}) async {
    try {
      UserModel userModel = await authDatasource.register(
          firstName: firstName,
          lastName: lastName,
          email: email,
          password: password);

      UserEntity userEntity = userModel.toEntity();
      return Right(userEntity);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<void> logout() {
    return authDatasource.logout();
  }
}
