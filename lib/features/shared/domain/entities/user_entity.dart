import 'package:equatable/equatable.dart';

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


