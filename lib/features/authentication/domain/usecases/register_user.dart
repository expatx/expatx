import '../../../shared/domain/usecases/usecases.dart';
import '../entities/logged_in_user.dart';
import '../repositories/auth_repository.dart';

class RegisterUser implements UseCase<void, SignupUserParams> {
  final AuthRepository authRepository;

  RegisterUser(this.authRepository);

  @override
  Future<void> call(SignupUserParams params) {
    // Add another repository to save the user into a database when he/she register.
    return authRepository.register(
      loggedInUser: params.user,
    );
  }
}

class SignupUserParams extends Params {
  final LoggedInUser user;

  SignupUserParams({required this.user});

  @override
  List<Object?> get props => [user];
}
