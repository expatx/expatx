import '../../../shared/domain/usecases/usecases.dart';
import '../repositories/auth_repository.dart';

class LoginUser implements UseCase<void, LoginUserParams> {
  final AuthRepository authRepository;

  LoginUser(this.authRepository);

  @override
  call(LoginUserParams params) async {
    return await authRepository.login(
      email: params.email,
      password: params.password,
    );
  }
}

class LoginUserParams extends Params {
  final String email;
  final String password;

  LoginUserParams({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [email, password];
}
