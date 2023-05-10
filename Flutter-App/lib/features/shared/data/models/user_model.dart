import '../../domain/entities/user_entity.dart';

class UserModel {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  // final Password? password;

  const UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    //  this.password,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      // password: json['password'],
    );
  }

  //The next two methods we are converting a User Entity to a User Model and vice versa.

  factory UserModel.fromEntity(UserEntity user) {
    return UserModel(
      id: user.id,
      firstName: user.firstName,
      lastName: user.lastName,
      email: user.email,
      // password: user.password,
    );
  }

  UserEntity toEntity() {
    return UserEntity(
      id: id,
      firstName: firstName,
      lastName: lastName,
      email: email,
      // password: password!,
    );
  }

  Map<String, dynamic> toLoginJson() => {
        "user": {
          "id": id,
          "first_name": firstName,
          "last_name": lastName,
          "email": email,
          // "password": password.value,
        }
      };

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        // "password": password.value,
      };

  static const empty = UserModel(
    id: 0,
    firstName: "User First",
    lastName: "User Last",
    email: "EmptyEmail@email.com",
  );
}
