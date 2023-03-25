import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

import '../../../../shared/domain/entities/user_entity.dart';

class LoginState extends Equatable {
  final Email email;
  final Password password;
  final FormzStatus status;
  final String? errorText;

  const LoginState({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.status = FormzStatus.pure,
    this.errorText,
  });

  factory LoginState.initial() {
    return const LoginState(
      email: Email.pure(),
      password: Password.pure(),
      status: FormzStatus.pure,
      errorText: null,
    );
  }

  LoginState copyWith({
    Email? email,
    Password? password,
    FormzStatus? status,
    String? errorText,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      errorText: errorText ?? this.errorText,
    );
  }

  @override
  List<Object?> get props => [email, password, status, errorText];
}
