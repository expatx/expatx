import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

class UserEntity extends Equatable {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  // final Password password;

  const UserEntity({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    // required this.password,
  });

  static const empty = UserEntity(
    id: 0,
    firstName: 'User',
    lastName: "user lastname",
    email: "emptyemail@email.com",
    // password: Password.pure(),
  );

  @override
  List<Object?> get props => [
        id,
        firstName,
        lastName,
        email,
      ];
}

enum EmailValidationError { invalid }

class Email extends FormzInput<String, EmailValidationError> {
  const Email.pure() : super.pure('');

  const Email.dirty([String value = '']) : super.dirty(value);

  static final RegExp _emailRegExp = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
  );

  @override
  EmailValidationError? validator(String value) {
    return _emailRegExp.hasMatch(value) ? null : EmailValidationError.invalid;
  }
}

enum PasswordValidationError { invalid }

class Password extends FormzInput<String, PasswordValidationError> {
  const Password.pure() : super.pure('');

  const Password.dirty([String value = '']) : super.dirty(value);

  static final _passwordRegExp =
      RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$');

  @override
  PasswordValidationError? validator(String? value) {
    return _passwordRegExp.hasMatch(value ?? '')
        ? null
        : PasswordValidationError.invalid;
  }
}
