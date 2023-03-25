import '../../../shared/domain/entities/user_entity.dart';

class LoggedInUser extends UserEntity {
  const LoggedInUser({
    required super.id,
    required super.firstName,
    required super.lastName,
    required super.email,
    // required super.password,
  });

  static const empty = LoggedInUser(
    id: 0,
    firstName: "User First",
    lastName: "User Last",
    email: Email.pure(),
    // password: Password.pure(),
  );

  @override
  List<Object?> get props => [
        id,
        firstName,
        lastName,
        email,
      ];

  LoggedInUser copyWith({
    int? id,
    String? firstName,
    String? lastName,
    Email? email,
    Password? password,
  }) {
    return LoggedInUser(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      // password: password ?? this.password,
    );
  }

  Map<String, dynamic> toJson() => {
        "user": {
          "first_name": firstName,
          "last_name": lastName,
          "email": email.value,
          // "password": password.value,
        }
      };
}
