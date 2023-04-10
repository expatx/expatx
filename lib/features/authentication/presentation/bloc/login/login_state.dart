import 'package:equatable/equatable.dart';

enum LoginFormStatus { initial, loading, success, error }

class LoginState extends Equatable {
  final String email;
  final String password;
  final LoginFormStatus status;
  final String? errorText;

  const LoginState({
    this.email = "email pure",
    this.password = "password pure",
    this.status = LoginFormStatus.initial,
    this.errorText,
  });

  factory LoginState.initial() {
    return const LoginState(
      email: "Emailllll",
      password: "Passworddddd",
      status: LoginFormStatus.initial,
      errorText: null,
    );
  }

  LoginState copyWith({
    String? email,
    String? password,
    LoginFormStatus? status,
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
