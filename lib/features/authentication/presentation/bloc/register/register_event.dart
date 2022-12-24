abstract class RegisterEvent {}

class RegisterFirstNameChanged extends RegisterEvent {
  final String firstName;

  RegisterFirstNameChanged({required this.firstName});
}

class RegisterLastNameChanged extends RegisterEvent {
  final String lastName;

  RegisterLastNameChanged({required this.lastName});
}

class RegisterEmailChanged extends RegisterEvent {
  final String email;

  RegisterEmailChanged({required this.email});
}

class RegisterPasswordChanged extends RegisterEvent {
  final String password;

  RegisterPasswordChanged({required this.password});
}

class RegisterSubmitted extends RegisterEvent {}
