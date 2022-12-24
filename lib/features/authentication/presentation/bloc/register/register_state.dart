import 'package:netigo_front/features/authentication/form_submission_status.dart';

class RegisterState {
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? password;

  bool get isValidFirstName {
    if (firstName!.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  bool get isValidLastName {
    if (lastName!.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  bool get isValidEmail {
    if (email!.length > 3 && email!.contains("@")) {
      return true;
    } else {
      return false;
    }
  }

  bool get isValidPassword {
    if (password!.length < 6) {
      return false;
    } else {
      return true;
    }
  }

  final FormSubmissionStatus? formStatus;

  RegisterState({
    this.firstName = '',
    this.lastName = '',
    this.email = '',
    this.password = '',
    this.formStatus = const InitialFormStatus(),
  });

  RegisterState copyWith({
    String? firstName,
    String? lastName,
    String? email,
    String? password,
    FormSubmissionStatus? formStatus,
  }) {
    return RegisterState(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      password: password ?? this.password,
      formStatus: formStatus ?? this.formStatus,
    );
  }
}
