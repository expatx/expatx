import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

import '../../../../shared/domain/entities/user_entity.dart';

class RegisterState extends Equatable {
  final String firstName;
  final String lastName;
  final Email email;
  final Password password;
  final FormzStatus status;
  final String? errorText;

  const RegisterState({
    this.firstName = '',
    this.lastName = '',
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.status = FormzStatus.pure,
    this.errorText,
  });

  factory RegisterState.initial() {
    return const RegisterState(
      firstName: "",
      lastName: "",
      email: Email.pure(),
      password: Password.pure(),
      status: FormzStatus.pure,
      errorText: null,
    );
  }

  RegisterState copyWith({
    String? firstName,
    String? lastName,
    Email? email,
    Password? password,
    FormzStatus? status,
    String? errorText,
  }) {
    return RegisterState(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      errorText: errorText ?? this.errorText,
    );
  }

  @override
  List<Object?> get props => [
        firstName,
        lastName,
        email,
        password,
        status,
        errorText,
      ];
}
