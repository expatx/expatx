import 'package:equatable/equatable.dart';

enum RegisterFormStatus { initial, loading, success, error }

class RegisterState extends Equatable {
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final RegisterFormStatus status;
  final String? errorText;

  const RegisterState({
    this.firstName = '',
    this.lastName = '',
    this.email = '',
    this.password = '',
    this.status = RegisterFormStatus.initial,
    this.errorText,
  });

  factory RegisterState.initial() {
    return const RegisterState(
      firstName: "",
      lastName: "",
      email: "",
      password: "",
      status: RegisterFormStatus.initial,
      errorText: null,
    );
  }

  RegisterState copyWith({
    String? firstName,
    String? lastName,
    String? email,
    String? password,
    RegisterFormStatus? status,
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
