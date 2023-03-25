import 'package:netigo_front/features/shared/domain/entities/user_entity.dart';

import '../../../shared/domain/usecases/usecases.dart';
import '../repositories/auth_repository.dart';

class RegisterUser implements UseCase<void, SignupUserParams> {
  final AuthRepository authRepository;

  RegisterUser(this.authRepository);

  @override
  call(SignupUserParams params) async {
    return await authRepository.register(
      firstName: params.firstName,
      lastName: params.lastName,
      email: params.email,
      password: params.password,
    );
  }
}

class SignupUserParams extends Params {
  final String firstName;
  final String lastName;
  final Email email;
  final Password password;

  SignupUserParams({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [firstName, lastName, email, password];
}
