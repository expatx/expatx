import 'package:netigo_front/authentication/form_submission_status.dart';

class LoginState {
  final String? email;
  final String? password;
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

  LoginState({
    this.email = '',
    this.password = '',
    this.formStatus = const InitialFormStatus(),
  });

  LoginState copyWith({
    String? email,
    String? password,
    FormSubmissionStatus? formStatus,
  }) {
    print("Email: ${this.email}");
    print("Password: ${this.password}");
    print("Form Status ${this.formStatus}");
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      formStatus: formStatus ?? this.formStatus,
    );
  }
}
